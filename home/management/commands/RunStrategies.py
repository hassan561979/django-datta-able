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
    help = 'run strategies'

    def add_arguments(self, parser):
        parser.add_argument('strategy_name', type=str)

    def handle(self, *args, **options):

        # exchange = ExchangeConnector("binance")
        # sell = Sell(exchange)
        # sell.doSell()
        strategy_name = options['strategy_name']
        exchange = ExchangeConnector("binance")

        # xx = threading.Thread(target=sell.doSell)
        # xx.start()

        strategy = Strategy.objects.get(name=strategy_name, status=1)

        PopulateCoins.getCoins(exchange)
        coins = Coin.objects.all()

        # for strategy in strategies:

        for strategy_time in strategy.strategy_times.filter(status=1):
            buy_obj = Buy(strategy, strategy_time,
                          coins, exchange)
            x = threading.Thread(target=buy_obj.doBuy)
            x.start()

        sell = SellTest(exchange)
        sell.doSell()
