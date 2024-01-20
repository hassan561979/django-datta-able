from django.core.management.base import BaseCommand
from home.ExchangeConnector import ExchangeConnector
from home.strategies.Backtest import BacktestView
from home.models import Coin
import os
import traceback
from home.models import Log
from time import sleep
from django.utils import timezone


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
        # symbols = Coin.objects.exclude(
        #    symbol__in=['MKRUSDT', 'TUSDUSDT', 'USDCUSDT', 'WBTCUSDT', 'YFIUSDT', 'BNBUSDT', 'ETHUSDT', 'BTCUSDT'])

        symbols = Coin.objects.filter(symbol='DOTUSDT')

        timeframe = options['timeframe']  # Daily timeframe, change as needed
        stoploss = options['stopLoss']
        start_date = '2023-06-01'  # Your start date
        end_date = '2024-01-18'    # Your end date

        exchange = ExchangeConnector('binance')
        initial_balance = 100
        for symbol in symbols:
            try:
                print('symbol: ' + symbol.symbol)
                backtest_view = BacktestView(
                    exchange, symbol.symbol, start_date, end_date, timeframe, initial_balance, stoploss, True)
                initial_balance = backtest_view.backtest()
                print('time frame: ' + timeframe + ',stop loss: ' +
                      str(stoploss) + ',profit : ' + str(initial_balance))
            except Exception as e:
                print(e)
                traceback_info = traceback.format_exc()
                Log.objects.create(log=traceback_info,
                                   created_at=timezone.now(), updated_at=timezone.now())
                continue

            finally:
                continue

        # print('time frame: ' + timeframe + ',stop loss: ' +
        #      str(stoploss) + ',final profit : ' + str(initial_balance))
