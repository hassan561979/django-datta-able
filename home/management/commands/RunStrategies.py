from django.core.management.base import BaseCommand
from home.ExchangeConnector import ExchangeConnector
from home.indicators.PopulateCoins import PopulateCoins
from home.models import StrategyTime
from home.models import Strategy
import os
from home.Buy import Buy
import threading


class Command(BaseCommand):
    help = 'run strategies'

    def handle(self, *args, **options):

        strategies = Strategy.objects.all()
        strategy_times = StrategyTime.objects.all()
        exchange = ExchangeConnector("binance")
        symbols = PopulateCoins.getCoins(exchange)

        for strategy in strategies:

            for strategy_time in strategy_times:
                buy_obj = Buy(strategy, strategy_time.time_frame,
                              symbols, exchange)
                x = threading.Thread(target=buy_obj.doBuy)
                x.start()
