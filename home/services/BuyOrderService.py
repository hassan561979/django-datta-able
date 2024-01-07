from home.models import BuyOrder
import datetime
import os
from django.utils import timezone


class BuyOrderService:

    def __init__(self, strategy, strategy_time, coin, exchange, signal) -> None:
        self.strategy = strategy
        self.strategy_time = strategy_time
        self.coin = coin
        self.exchange = exchange
        self.signal = signal
        self.createBuyOrder()

    def createBuyOrder(self):
        buy_order = BuyOrder.objects.filter(
            strategy_id=self.strategy.id, coin_id=self.coin.id, time_frame_id=self.strategy_time.id).last()

        if buy_order and hasattr(buy_order, 'sell_orders') == None:
            print('found')
            return
        else:

            print('not found')

            ticker = self.exchange.fetch_ticker(self.coin.symbol)
            current_price = ticker['last']
            amount_per_order = self.strategy_time.amount_per_order

            BuyOrder.objects.create(
                buy_price=current_price,
                buy_amount=amount_per_order / current_price,
                buy_total=(amount_per_order / current_price) * current_price,
                indicators=self.signal,
                coin_id=self.coin.id,
                strategy_id=self.strategy.id,
                time_frame_id=self.strategy_time.id,
                buy_created_at=timezone.now(),
                buy_updated_at=timezone.now()
            )
