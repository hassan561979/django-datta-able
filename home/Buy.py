
from datetime import datetime
from time import sleep
import os
from home.strategies.AwesomeStochBbSar import AwesomeStochBbSar
from home.services.BuyOrderService import BuyOrderService
import traceback
from home.models import Log
from django.utils import timezone
from home.models import BuyOrder
from home.strategies.AwesomeStochBbSarEma200 import AwesomeStochBbSarEma200
from home.strategies.AwesomeStochBbSarEma200_2 import AwesomeStochBbSarEma200_2


class Buy:
    def __init__(self, strategy, strategy_time, coins, exchange) -> None:
        self.strategy = strategy
        self.strategy_time = strategy_time
        self.coins = coins
        self.exchange = exchange

    def doBuy(self) -> None:
        dynamic_class = globals()[self.strategy.function_name]
        while True:
            print('loop start' + ':' + str(datetime.now()) + ':' +
                  self.strategy.function_name + ' : ' + self.strategy_time.time_frame)
            print('====================================================')

            for coin in self.coins:
                try:
                    buy_orders_without_sell = BuyOrder.objects.filter(
                        sellorder__isnull=True)
                    if len(buy_orders_without_sell) >= 200:
                        continue
                    else:
                        buy_order = BuyOrder.objects.filter(
                            strategy_id=self.strategy.id, coin_id=coin.id, time_frame_id=self.strategy_time.id).last()

                        sleep(0.1)
                        strategy_obj = dynamic_class(
                            self.exchange, coin.symbol, self.strategy_time.time_frame, 1)

                        signal = strategy_obj.get_signals()
                        if signal['signal'] == 1:
                            BuyOrderService(
                                self.strategy, self.strategy_time, coin, self.exchange, signal)
                            print(str(datetime.now()) + ':' + self.strategy.function_name + ' : ' + self.strategy_time.time_frame +
                                  ':' + coin.symbol + ':{}'.format(signal))
                            print(
                                '====================================================')

                            # signal=AwesomeStochBbSar(exchange,symbol,'5m',-1).get_signals()
                            # print (symbol + ':{}'.format(signal))
                except Exception as e:
                    traceback_info = traceback.format_exc()
                    Log.objects.create(log=traceback_info,
                                       created_at=timezone.now(), updated_at=timezone.now())
                    continue

                finally:
                    continue

            print('loop end' + ':' + str(datetime.now()) + ':' +
                  self.strategy.function_name + ' : ' + self.strategy_time.time_frame)
