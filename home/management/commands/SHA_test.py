from django.core.management.base import BaseCommand
from home.ExchangeConnector import ExchangeConnector
from home.models import Coin
import os
import traceback
from home.models import Log
from time import sleep
from django.utils import timezone
import requests
from datetime import datetime
import pandas as pd
import backtrader as bt

class MyStrategy(bt.Strategy):
    params = (
        ("period", 6),
        ("fastend", 0.666),
        ("slowend", 0.0645),
        ("hakamaper", 1),
    )

    def __init__(self):
        # Define indicators
        self.ma05 = bt.indicators.SimpleMovingAverage(self.data.close, period=5)
        self.ma100 = bt.indicators.SimpleMovingAverage(self.data.close, period=100)

        # Define custom KAMA indicator
        self.kama = self.kama(self.data.close, self.params.period)

        # Initialize plot lines
        self.long_arrow = bt.plotting.PlotLines(color='blue', linestyle='-', plotabove=True)
        self.short_arrow = bt.plotting.PlotLines(color='red', linestyle='-', plotabove=False)
        self.close_long_arrow = bt.plotting.PlotLines(color='purple', linestyle='-', plotabove=False)
        self.close_short_arrow = bt.plotting.PlotLines(color='purple', linestyle='-', plotabove=True)

    def kama(self, close, amaLength):
        # Implement the KAMA function
        # ... (use the provided Pine Script kama function as reference)

    def next(self):
        vClose = (self.data.open + self.data.high + self.data.low + self.data.close) / 4
        vOpen = self.kama(vClose(-1), self.params.hakamaper)
        vHigh = max(self.data.high, max(vClose, vOpen))
        vLow = min(self.data.low, min(vClose, vOpen))
        sha_signal = vOpen > vClose

        long_condition = sha_signal and self.ma05 > self.ma100 and self.ma05[-6] > self.ma100[-6] and vOpen > vClose
        short_condition = sha_signal and self.ma05 < self.ma100 and self.ma05[-6] < self.ma100[-6] and vOpen < vClose
        close_long_condition = self.ma05 > self.ma100 and (mmar_close or sha_signal) and vOpen < vClose
        close_short_condition = self.ma05 < self.ma100 and (mmar_close or sha_signal) and vOpen > vClose

        if long_condition:
            self.long_arrow[0] = self.data.close
            self.buy()
        elif short_condition:
            self.short_arrow[0] = self.data.close
            self.sell()
        elif close_long_condition:
            self.close_long_arrow[0] = self.data.close
            self.close()
        elif close_short_condition:
            self.close_short_arrow[0] = self.data.close
            self.close()

class Command(BaseCommand):
    help = 'run strategies'

    def add_arguments(self, parser):
        parser.add_argument('timeframe', type=str,
                            help='OHLCV timeframe, e.g., 1d for daily')
        parser.add_argument('stoploss', type=float,
                            help='stop loss')

    def handle(self, *args, **options):
        fear_greed_api_url = f'https://api.alternative.me/fng/?limit=0'
        response = requests.get(fear_greed_api_url)
        FearGreedDf = pd.DataFrame(response.json()['data'])
        FearGreedDf.timestamp = pd.to_datetime(FearGreedDf.timestamp, unit='s')
        FearGreedDf.set_index('timestamp', inplace=True)

        # Change it according to your requirements
        # symbols = ['APE/USDT', 'SOL/USDT', 'DOT/USDT', 'MOVR/USDT']
        symbols = Coin.objects.exclude(
            symbol__in=['MKRUSDT', 'TUSDUSDT', 'USDCUSDT', 'WBTCUSDT', 'YFIUSDT', 'BNBUSDT', 'ETHUSDT', 'BTCUSDT']).order_by('?')[:30]

        # symbols = Coin.objects.filter(symbol__in=['XECUSDT', 'OAXUSDT', 'ATMUSDT', 'OOKIUSDT', 'DREPUSDT', 'LPTUSDT', 'APEUSDT', 'SOLUSDT', 'DOTUSDT', 'MOVRUSDT',
        #                                          'XRPUSDT', 'LINKUSDT', 'ADAUSDT', 'DOGEUSDT', 'XLMUSDT'])

        # symbols = Coin.objects.filter(
        #    symbol__in=['SOLUSDT', 'DOGEUSDT', 'ADAUSDT', 'XECUSDT'])

        timeframe = options['timeframe']  # Daily timeframe, change as needed
        stoploss = options['stoploss']  # Daily timeframe, change as needed

        # start_date = '2022-02-17'  # Your start date
        # end_date = '2022-05-26'    # Your end date

        # start_date = '2023-01-01'  # Your start date // very bearish
        # end_date = '2024-01-28'    # Your end date

        # start_date = '2021-12-08'  # Your start date // very bearish
        # end_date = '2022-04-15'    # Your end date

        # start_date = '2021-12-20'  # Your start date // very bearish
        # end_date = '2021-12-25'    # Your end date

        # start_date = '2023-01-01'  # Your start date // very bearish
        # end_date = '2023-03-01'    # Your end date

        exchange = ExchangeConnector('binance')
        initial_balance = 110
        # maker_fee = exchange.fetch_maker_fee()
        # taker_fee = exchange.fetch_taker_fee()
        profit_history = False

        start_date = '2023-10-25'
        end_date = '2024-02-17'

        # start_date = '2023-03-19'
        # end_date = '2023-05-09'

        for symbol in symbols:
            try:
                print('-------------------------------' + 'symbol: ' +
                      symbol.symbol + '--------------------------')
                if profit_history == False:
                    # symbol_obj = Coin.objects.filter(symbol=symbol).first()
                    # profit_percent = symbol_obj.strategy_profit['S1']
                    profit_percent = 0
                    print('profit percent: ' + str(profit_percent))
                    # if profit_percent < 20:
                    #    continue

                backtest_view = BacktestView(
                    exchange, symbol.symbol,
                    start_date, end_date, timeframe, stoploss, initial_balance, plot=False, FearGreedDf=FearGreedDf)
                result = backtest_view.backtest()
                profit = result[0]

                if profit_history == False:
                    initial_balance = result[0]
                else:

                    profit_percent = ((profit - initial_balance) * 100) / 100
                    Coin.objects.filter(symbol=symbol).update(
                        strategy_profit={"S1": profit_percent})

                last_date = result[1]
                # start_date = start_date if last_date == 0 else last_date

                print('S10 last date: ' + str(last_date) +
                      ',time frame: ' + timeframe + ',stoploss: ' + str(stoploss) + ',profit : ' + str(profit))
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


# 50 coin
#    params = (
#        ("ema_period", 200),
#        ("psar_af", 0.02),
#        ("psar_max_af", 0.02),
#        ("bbands_period", 10),
#        ("bbands_dev", 2),
#        ("stochastic_period", 14),
#        ("stochastic_d_period", 3),
#        ("atr_period", 14),
#        ("stop_loss_percent", None),  # 1.0% stop-loss
