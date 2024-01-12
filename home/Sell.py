
from datetime import datetime
from time import sleep
import os
from home.strategies.AwesomeStochBbSar import AwesomeStochBbSar
from home.services.SellOrderService import SellOrderService
from home.models import BuyOrder
import traceback
from home.models import Log
from django.utils import timezone
from home.services.StopLoss import StopLoss
from home.strategies.AwesomeStochBbSarEma200 import AwesomeStochBbSarEma200
from home.strategies.AwesomeStochBbSarEma200_2 import AwesomeStochBbSarEma200_2
import threading


class Sell:
    def __init__(self, exchange) -> None:
        self.exchange = exchange

    def doSell(self) -> None:
        while True:
            try:
                buy_orders_without_sell = BuyOrder.objects.filter(
                    sellorder__isnull=True)
                for order in buy_orders_without_sell:
                    bb = threading.Thread(target=self.doSellCoin(order))
                    bb.start()

            except Exception as e:
                traceback_info = traceback.format_exc()
                Log.objects.create(log=traceback_info,
                                   created_at=timezone.now(), updated_at=timezone.now())
                continue

            finally:
                continue

    def doSellCoin(self, order) -> None:
        while True:
            try:
                stop_loss = StopLoss(order, self.exchange).checkStopLoss()
                print(stop_loss)
                if stop_loss == True:
                    signal = 'Stop loss = {}'.format(order.calc_stop_loss)
                    SellOrderService(order,
                                     order.strategy, order.time_frame, order.coin, self.exchange, signal)
                else:
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
                        print(
                            '====================================================')

                        # signal=AwesomeStochBbSar(exchange,symbol,'5m',-1).get_signals()
                        # print (symbol + ':{}'.format(signal))

                print('doing sell : ' + order.coin.symbol +
                      ',' + order.time_frame.time_frame)
            except Exception as e:
                traceback_info = traceback.format_exc()
                Log.objects.create(log=traceback_info,
                                   created_at=timezone.now(), updated_at=timezone.now())
                continue

            finally:
                continue
