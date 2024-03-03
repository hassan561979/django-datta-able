from home.models import BuyOrder
import datetime
import os
from django.utils import timezone
from home.models import StrategyTime
from datetime import timedelta


class BuyOrderService:

    def __init__(self, strategy, strategy_time, coin, exchange, signal) -> None:
        self.strategy = strategy
        self.strategy_time = strategy_time
        self.coin = coin
        self.exchange = exchange
        self.signal = signal
        self.createBuyOrder()

    def createBuyOrder(self):
        balance = StrategyTime.objects.get(id=self.strategy_time.id).balance
        print('balance: ' + str(balance))

        if balance < 30:
            return
        # percent_per_order = self.strategy_time.amount_per_order
        buy_orders_without_sell = BuyOrder.objects.filter(
            time_frame_id=self.strategy_time.id, sellorder__isnull=True)

        print("orders without sell: " + str(len(buy_orders_without_sell)))
        max_orders = 10 - len(buy_orders_without_sell)
        print('max orders: ' + str(max_orders))
        cost_per_order = (balance-20) / max_orders
        print('cost_per_order: ' + str(cost_per_order))

        ticker = self.exchange.fetch_ticker(self.coin.symbol)
        current_price = ticker['last']

        amount_per_order = cost_per_order / current_price
        fees = amount_per_order * 0.001
        amount_per_order = amount_per_order - fees

        current_time = timezone.now()
        adjusted_time = current_time + timedelta(hours=3)

        BuyOrder.objects.create(
            buy_price=current_price,
            buy_amount=amount_per_order,
            buy_total=cost_per_order,
            indicators=self.signal,
            coin_id=self.coin.id,
            strategy_id=self.strategy.id,
            time_frame_id=self.strategy_time.id,
            buy_created_at=adjusted_time,
            buy_updated_at=adjusted_time
        )

        strategy_time = StrategyTime.objects.get(id=self.strategy_time.id)
        strategy_time.balance = strategy_time.balance - cost_per_order
        strategy_time.save()
