from django.core.management.base import BaseCommand
from home.ExchangeConnector import ExchangeConnector
from home.strategies.Backtest import BacktestView
from home.models import Coin
import os


class Command(BaseCommand):
    help = 'run strategies'

    def add_arguments(self, parser):
        parser.add_argument('timeframe', type=str,
                            help='OHLCV timeframe, e.g., 1d for daily')
        parser.add_argument('stopLoss', type=float,
                            help='stop loss')

    def handle(self, *args, **options):

        # Change it according to your requirements
        # symbols = ['APE/USDT', 'SOL/USDT', 'DOT/USDT', 'MOVR/USDT']
        symbols = Coin.objects.exclude(
            symbol__in=['TUSDUSDT', 'USDCUSDT', 'WBTCUSDT', 'YFIUSDT', 'BNBUSDT', 'ETHUSDT', 'BTCUSDT'])[:5]

        timeframe = options['timeframe']  # Daily timeframe, change as needed
        start_date = '2023-06-01'  # Your start date
        end_date = '2024-01-17'    # Your end date

        print("Beep!\a")
        exchange = ExchangeConnector('binance')
        initial_balance = 100
        for symbol in symbols:
            print('symbol: ' + symbol.symbol)
            backtest_view = BacktestView(
                exchange, symbol.symbol, start_date, end_date, timeframe, initial_balance)
            initial_balance = backtest_view.backtest()
            print('profit : ' + str(initial_balance))

        print(timeframe + 'final profit : ' + str(initial_balance))
        print("Beep!\a")
