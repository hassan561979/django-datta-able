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


class Command(BaseCommand):
    help = 'run strategies'

    def handle(self, *args, **options):

        exchange = ExchangeConnector("binance")
        sell = Sell(exchange)
        xx = threading.Thread(target=sell.doSell)
        xx.start()

        strategies = Strategy.objects.all()
        PopulateCoins.getCoins(exchange)
        coins = Coin.objects.all()

        for strategy in strategies:
            # print(strategy.id)
            # os.abort()
            for strategy_time in strategy.strategy_times.all():
                buy_obj = Buy(strategy, strategy_time,
                              coins, exchange)
                x = threading.Thread(target=buy_obj.doBuy)
                x.start()
