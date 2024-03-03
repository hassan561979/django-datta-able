from django.core.management.base import BaseCommand
from home.ExchangeConnector import ExchangeConnector
from home.PandasUtil import PandasUtil as pu
from home.indicators.AwesomeBBands import AwesomeBBands
import os
from home.models import Coin
from home.models import BuyOrder


class Command(BaseCommand):
    help = 'test'
    threads_orders = {}

    def handle(self, *args, **options):
        exchange = ExchangeConnector("binance")
     
        # markets = exchange.load_markets()
        # symbol_names = list(markets.keys())

        # print("All Binance Trading Symbols:")
        # print(symbol_names)

        # symbols = ['DENTUSDT', 'BTCUSDT', 'HOT/USDT', 'SOL/USDT',
        #           'MOVR/USDT', 'BNB/USDT', 'ETH/USDT', 'DOGEUSDT', 'ADAUSDT']

        # symbols = ['HOTUSDT']

        coins = Coin.objects.all()
        # for x in range(200):
        for symbol in coins:
            ohlcv = exchange.fetch_ohlcv(symbol.symbol, "5m")

            df = pu.create_data_frame(ohlcv)

            # Instantiate the BollingerBandsStrategy class
            bb = AwesomeBBands(df, exchange, symbol.symbol, 20, 2.0)

            # Get the signals DataFrame
            signals = bb.get_signals()
            if signals['signal'] == 1:
                # if signals ==-1 or signals==1:
                print('-----------' + symbol.symbol + '-----------')
                print(str(signals))
