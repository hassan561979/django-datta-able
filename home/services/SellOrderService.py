from home.models import SellOrder
import datetime
import os
from django.utils import timezone


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
            sell_created_at=timezone.now(),
            sell_updated_at=timezone.now()
        )
