
from datetime import datetime
from time import sleep
import os
from home.AwesomeStochBbSar import AwesomeStochBbSar


class Buy:
    def __init__(self, strategy, time_frame, symbols, exchange) -> None:
        self.strategy = strategy
        self.time_frame = time_frame
        self.symbols = symbols
        self.exchange = exchange

    def doBuy(self) -> None:
        dynamic_class = globals()[self.strategy.function_name]
        while True:
            print('loop start' + ':' + str(datetime.now()) + ':' +
                  self.strategy.function_name + ' : ' + self.time_frame)
            print('====================================================')

            for symbol in self.symbols:
                try:
                    sleep(0.1)
                    strategy_obj = dynamic_class(
                        self.exchange, symbol, self.time_frame, 1)

                    signal = strategy_obj.get_signals()
                    if signal['signal'] == 1:
                        print(str(datetime.now()) + ':' + self.strategy.function_name + ' : ' + self.time_frame +
                              ':' + symbol + ':{}'.format(signal))
                        print('====================================================')

                        # signal=AwesomeStochBbSar(exchange,symbol,'5m',-1).get_signals()
                        # print (symbol + ':{}'.format(signal))
                except Exception as e:
                    print(f"An error occurred: {e}")
                    continue

                finally:
                    continue

            print('loop end' + ':' + str(datetime.now()) + ':' +
                  self.strategy.function_name + ' : ' + self.time_frame)
