
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
from concurrent.futures import ThreadPoolExecutor, as_completed
import time


class SellTest:
    def __init__(self, exchange) -> None:
        self.exchange = exchange

    def doSell(self) -> None:
        # Number of tasks to run in parallel
        num_tasks = 2

        # Using ThreadPoolExecutor to run tasks in parallel
        with ThreadPoolExecutor(max_workers=num_tasks) as executor:
            # Submit each task to the executor
            for i in range(num_tasks):
                future_to_task = {executor.submit(
                    self.long_running_task, i)}

            # Wait for all tasks to complete
            for future in as_completed(future_to_task):
                task_id = future_to_task[future]
                try:
                    # Retrieve the result of each task
                    result = future.result()
                    self.stdout.write(self.style.SUCCESS(
                        f"Task {task_id} result: {result}"))
                except Exception as e:
                    self.stderr.write(self.style.ERROR(
                        f"Task {task_id} failed with exception: {e}"))

    def long_running_task(self, task_id):
        while True:
            # Simulate a long-running task
            self.stdout.write(self.style.SUCCESS(f"Task {task_id} started"))
            if task_id == 1:
                time.sleep(1)
            else:
                time.sleep(5)

            self.stdout.write(self.style.SUCCESS(f"Task {task_id} completed"))

    def doSellCoin(self, order) -> None:
        # while True:
        try:
            stop_loss = StopLoss(order, self.exchange).checkStopLoss()
            print(stop_loss)
            if stop_loss == True:
                signal = 'Stop loss = {}'.format(order.calc_stop_loss)
                SellOrderService(order,
                                 order.strategy, order.time_frame, order.coin, self.exchange, signal)
            else:
                dynamic_class = globals()[order.strategy.function_name]
                # sleep(0.1)
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
            print(e)
            traceback_info = traceback.format_exc()
            Log.objects.create(log=traceback_info,
                               created_at=timezone.now(), updated_at=timezone.now())
            # continue

        finally:
            # continue
            return
