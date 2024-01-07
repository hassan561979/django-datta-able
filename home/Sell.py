
from datetime import datetime
from time import sleep
import os
from home.AwesomeStochBbSar import AwesomeStochBbSar
from home.services.SellOrderService import SellOrderService
from home.models import BuyOrder
import traceback
from home.models import Log


class Sell:
    def __init__(self, exchange) -> None:
        self.exchange = exchange

    def doSell(self) -> None:
        while True:
            try:
                buy_orders_without_sell = BuyOrder.objects.filter(
                    sellorder__isnull=True)
                for order in buy_orders_without_sell:

                    dynamic_class = globals()[order.strategy.function_name]
                    sleep(0.1)
                    strategy_obj = dynamic_class(
                        self.exchange, order.coin.symbol, order.time_frame.time_frame, -1)

                    signal = strategy_obj.get_signals()
                    if signal['signal'] == -1:
                        SellOrderService(order,
                                         order.strategy, order.time_frame, order.coin, self.exchange, signal)
                        print(
                            '====================================sell=====================')
                        print(str(datetime.now()) + ':' + order.strategy.function_name + ' : ' + order.time_frame.time_frame +
                              ':' + order.coin.symbol + ':{}'.format(signal))
                        print('====================================================')

                        # signal=AwesomeStochBbSar(exchange,symbol,'5m',-1).get_signals()
                        # print (symbol + ':{}'.format(signal))

                print('doing sell')
            except Exception as e:
                traceback_info = traceback.format_exc()
                Log.objects.create(log=traceback_info)
                continue

            finally:
                continue
