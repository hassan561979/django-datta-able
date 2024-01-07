
from datetime import datetime
from time import sleep
import os
from home.AwesomeStochBbSar import AwesomeStochBbSar
from home.services.BuyOrderService import BuyOrderService
import traceback
from home.models import Log


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
                    sleep(0.1)
                    strategy_obj = dynamic_class(
                        self.exchange, coin.symbol, self.strategy_time.time_frame, 1)

                    signal = strategy_obj.get_signals()
                    if signal['signal'] == 1:
                        BuyOrderService(
                            self.strategy, self.strategy_time, coin, self.exchange, signal)
                        print(str(datetime.now()) + ':' + self.strategy.function_name + ' : ' + self.strategy_time.time_frame +
                              ':' + coin.symbol + ':{}'.format(signal))
                        print('====================================================')

                        # signal=AwesomeStochBbSar(exchange,symbol,'5m',-1).get_signals()
                        # print (symbol + ':{}'.format(signal))
                except Exception as e:
                    traceback_info = traceback.format_exc()
                    Log.objects.create(log=traceback_info)
                    continue

                finally:
                    continue

            print('loop end' + ':' + str(datetime.now()) + ':' +
                  self.strategy.function_name + ' : ' + self.strategy_time.time_frame)
