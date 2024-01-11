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
from home.strategies.AwesomeStochBbSarEma200 import AwesomeStochBbSarEma200


class Command(BaseCommand):
    help = 'test'

    def handle(self, *args, **options):
        exchange = ExchangeConnector("binance")

    # symbols = ['BTCUSDT','HOT/USDT','SOL/USDT','MOVR/USDT','BNB/USDT','ETH/USDT']
    symbols = ['ETHUSDT']
    # symbols = ['API3USDT']
    # symbols = PopulateCoins.getCoins(exchange)
    # print(symbols)
    exchange = ExchangeConnector('binance')
    for coin in Coin.objects.all():
        signal = AwesomeStochBbSarEma200(exchange, coin.symbol, '5m', 1)
        print(coin.symbol + ':' + str(signal.signals))
