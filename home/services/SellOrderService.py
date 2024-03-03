from home.models import SellOrder
import datetime
import os
from django.utils import timezone
from home.models import StrategyTime
from datetime import timedelta


class SellOrderService:

    def __init__(self, buy_order, strategy, strategy_time, coin, exchange, signal) -> None:
        self.buy_order = buy_order
        self.strategy = strategy
        self.strategy_time = strategy_time
        self.coin = coin
        self.exchange = exchange
        self.signal = signal
        self.createSellOrder()

    def createSellOrder(self):
       
        ticker = self.exchange.fetch_ticker(self.coin.symbol)
        current_price = ticker['last']
        sell_total = self.buy_order.buy_amount * current_price
        fees = sell_total * 0.001
        sell_total = sell_total - fees

        current_time = timezone.now()
        adjusted_time = current_time + timedelta(hours=3)

        SellOrder.objects.create(
            sell_price=current_price,
            sell_amount=self.buy_order.buy_amount,
            sell_total=sell_total,
            profit=sell_total - self.buy_order.buy_total,
            indicators=self.signal,
            buy_order_id=self.buy_order.id,
            coin_id=self.coin.id,
            strategy_id=self.strategy.id,
            time_frame_id=self.strategy_time.id,
            sell_created_at=adjusted_time,
            sell_updated_at=adjusted_time
        )

        strategy_time = StrategyTime.objects.get(id=self.strategy_time.id)
        strategy_time.balance = strategy_time.balance + sell_total
        strategy_time.save()
