from django.core.management.base import BaseCommand
from home.ExchangeConnector import ExchangeConnector
from home.indicators.PopulateCoins import PopulateCoins
from home.models import StrategyTime
from home.models import Strategy, StrategyTime
import os
from home.Buy import Buy
import threading
from home.models import Coin
from home.Sell import Sell
from home.SellTest import SellTest
from home.ParallelTaskRunner import ParallelTaskRunner


class Command(BaseCommand):

    def handle(self, *args, **options):
        exchange = ExchangeConnector("binance")

        PopulateCoins.getCoins(exchange)
