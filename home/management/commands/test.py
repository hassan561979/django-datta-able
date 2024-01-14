from django.core.management.base import BaseCommand
from home.ExchangeConnector import ExchangeConnector
from home.indicators.PopulateCoins import PopulateCoins
from home.models import StrategyTime
from home.models import Strategy, StrategyTime
import os
from home.Buy import Buy
import threading
from home.models import Coin
from home.models import Log
from pprint import pprint
import traceback
from home.PandasUtil import PandasUtil as pu
from home.models import BuyOrder
from home.ExchangeConnector import ExchangeConnector
import pandas as pd
from home.indicators.Ema import Ema
from home.strategies.AwesomeStochBbSarEma200_2 import AwesomeStochBbSarEma200_2
from home.Sell import Sell
from time import sleep
from django.conf import settings


class Command(BaseCommand):
    help = 'test'
    threads_orders = {}

    def handle(self, *args, **options):
        exchange = ExchangeConnector("binance")

        self.doSell()
        # sell = Sell(exchange)
        # xx = threading.Thread(target=self.doSell, daemon=True)
        # xx.start()
        # self.doSell2()

    def doSell2(self, order) -> None:
        # while True:
        print('doing sell : ' + order.coin.symbol +
              ',' + order.time_frame.time_frame)
        sleep(2)

    def doSell(self) -> None:
        # while True:
        # try:
        buy_orders_without_sell = BuyOrder.objects.filter(
            sellorder__isnull=True)
        print(len(buy_orders_without_sell))

        for order in buy_orders_without_sell:
            # print(order.coin.symbol)
            # sleep(2)
            self.doSellCoin(order)

        # except Exception as e:
       # traceback_info = traceback.format_exc()
       # Log.objects.create(log=traceback_info,
       #                    created_at=timezone.now(), updated_at=timezone.now())
        # continue

        # finally:
        #    continue

    def doSellCoin(self, order) -> None:
        # while True:
        # try:
        self.threads_orders[order.id] = threading.Thread(
            target=self.doSell2(order), daemon=True)
        self.threads_orders[order.id].start()

        # except Exception as e:
        # traceback_info = traceback.format_exc()
        # Log.objects.create(log=traceback_info,
        #                   created_at=timezone.now(), updated_at=timezone.now())
        # continue

        # finally:
        #    continue
