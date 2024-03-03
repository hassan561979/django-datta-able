
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
from concurrent.futures import ThreadPoolExecutor, wait
import time
from home.strategies.AwesomeStochBbSarEma200_3 import AwesomeStochBbSarEma200_3
from home.strategies.S10 import S10


class SellTest:
    def __init__(self, exchange) -> None:
        self.exchange = exchange

    def doSell(self) -> None:
        while True:
            try:
                buy_orders_without_sell = BuyOrder.objects.filter(
                    sellorder__isnull=True)

                num_tasks = len(buy_orders_without_sell)
                if num_tasks == 0:
                    continue
                # for order in buy_orders_without_sell:
                # bb = threading.Thread(target=self.doSellCoin(order))
                # bb.start()
                # Using ThreadPoolExecutor to run tasks in parallel
                with ThreadPoolExecutor(max_workers=num_tasks) as executor:
                    # Submit each task to the executor
                    futures = [executor.submit(self.doSellCoin, order)
                               for order in buy_orders_without_sell]

                    # Wait for all tasks to complete
                    wait(futures)

                    # Retrieve the results (optional)
                    # results = [future.result() for future in futures]
                    # return results

            except Exception as e:
                print(e)
                traceback_info = traceback.format_exc()
                Log.objects.create(log=traceback_info,
                                   created_at=timezone.now(), updated_at=timezone.now())
                # sleep(0.5)
            finally:
                continue

    def doSellCoin(self, order) -> None:

        stop_loss = StopLoss(order, self.exchange)

        sell_result, stop_loss_price = stop_loss.calc_atr_stop_loss()

        if sell_result == -1:

            signal = 'Stop loss = {}'.format(stop_loss_price)

            SellOrderService(order, order.strategy, order.time_frame,
                             order.coin, self.exchange, signal)

        else:
            dynamic_class = globals()[order.strategy.function_name]
            strategy_obj = dynamic_class(
                self.exchange, order.coin.symbol, order.time_frame.time_frame, -1)
            signal = strategy_obj.get_signals()
            # print(order.coin.symbol +
            #      ',' + order.time_frame.time_frame + ' signal : ' + str(signal))

            if signal['signal'] == -1:
                SellOrderService(order,
                                 order.strategy, order.time_frame, order.coin, self.exchange, signal)
                print(
                    '====================================sell=====================')
                print(str(datetime.now()) + ':' + order.strategy.function_name + ' : ' + order.time_frame.time_frame +
                      ':' + order.coin.symbol + ':{}'.format(signal))
                print(
                    '====================================================')

                print('sold : ' + order.coin.symbol +
                      ',' + order.time_frame.time_frame)

                # signal=AwesomeStochBbSar(exchange,symbol,'5m',-1).get_signals()
                # print (symbol + ':{}'.format(signal))

        # print('doing sell : ' + order.coin.symbol +
        #      ',' + order.time_frame.time_frame)
