from django.core.management.base import BaseCommand
from home.ExchangeConnector import ExchangeConnector
from home.strategies.S3_test import BacktestView
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
        symbols = Coin.objects.exclude(
            symbol__in=['MKRUSDT', 'TUSDUSDT', 'USDCUSDT', 'WBTCUSDT', 'YFIUSDT', 'BNBUSDT', 'ETHUSDT', 'BTCUSDT']).order_by('?')[:100]

        # symbols = Coin.objects.filter(symbol__in=['XRPUSDT'])

        timeframe = options['timeframe']  # Daily timeframe, change as needed
        stoploss = options['stopLoss']

        # start_date = '2022-02-17'  # Your start date
        # end_date = '2022-05-26'    # Your end date

        # start_date = '2023-01-01'  # Your start date // very bearish
        # end_date = '2024-01-28'    # Your end date

        start_date = '2021-12-08'  # Your start date // very bearish
        end_date = '2022-04-15'    # Your end date

        # start_date = '2023-01-01'  # Your start date // very bearish
        # end_date = '2023-03-01'    # Your end date

        exchange = ExchangeConnector('binance')
        initial_balance = 150
        # maker_fee = exchange.fetch_maker_fee()
        # taker_fee = exchange.fetch_taker_fee()
        profit_history = False

        for symbol in symbols:
            try:
                print('-------------------------------' + 'symbol: ' +
                      symbol.symbol + '--------------------------')
                if profit_history == False:
                    symbol_obj = Coin.objects.filter(symbol=symbol).first()
                    profit_percent = symbol_obj.strategy_profit['S1']
                    print('profit percent: ' + str(profit_percent))
                    # if profit_percent < 0.2:
                    #    continue

                backtest_view = BacktestView(
                    exchange, symbol.symbol, start_date, end_date, timeframe, initial_balance, stoploss, plot=False)
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

                print('last date: ' + str(last_date) + ',time frame: ' + timeframe + ',stop loss: ' +
                      str(stoploss) + ',profit : ' + str(profit))
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

# last date: 2024-01-30,time frame: 30m,stop loss: 9.0,profit : 1077.0913141720484
# last date: 2024-01-30,time frame: 30m,stop loss: 10.0,profit : 1096.6328901764184
# last date: 2024-01-30,time frame: 30m,stop loss: 11.0,profit : 1120.587554420635
# last date: 2024-01-30,time frame: 30m,stop loss: 12.0,profit : 1134.065288159445
# last date: 2024-01-30,time frame: 30m,stop loss: 14.0,profit : 1141.2100946517542
# last date: 2024-01-30,time frame: 30m,stop loss: 15.0,profit : 1149.0362268424756
# last date: 2024-01-30,time frame: 30m,stop loss: 16.0,profit : 1418.6353742554522
