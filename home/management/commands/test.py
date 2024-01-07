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


class Command(BaseCommand):
    help = 'test'

    def handle(self, *args, **options):
        try:
            sjadfsa
        except Exception as e:
            traceback_info = traceback.format_exc()
            Log.objects.create(log=traceback_info)
