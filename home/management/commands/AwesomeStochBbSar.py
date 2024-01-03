from django.core.management.base import BaseCommand
from home.ExchangeConnector import ExchangeConnector
from home.indicators.PopulateCoins import PopulateCoins
from datetime import datetime
from time import sleep
import pandas as pd
from home.PandasUtil import PandasUtil as pu;
from home.indicators.AwesomeStoch import AwesomeStoch
from home.indicators.Psar import Psar
from home.indicators.BollingerBands import BollingerBands

from home.models import Coin
class Command(BaseCommand):
    help = 'My custom command description'

    def handle(self, *args, **options):
        exchange = ExchangeConnector("binance")
  
        #symbols = ['BTCUSDT','HOT/USDT','SOL/USDT','MOVR/USDT','BNB/USDT','ETH/USDT']
        #symbols = ['API3USDT']
        symbols = PopulateCoins.getCoins(exchange)
        #print(symbols)

        print(str(datetime.now()) + ' : ')
        while True:
                for symbol in symbols:
                    try:
                        ohlcv = exchange.fetch_ohlcv(symbol, "5m")
                    
                        df = pu.create_data_frame(ohlcv)
                        # Instantiate the BollingerBandsStrategy class
                        psar = Psar(df)
                        psar_signal=psar.get_signals()
                        if psar_signal['signal'] < 1:
                            continue

                        stoch = AwesomeStoch(df)
                        stoch_signal = stoch.get_signals()

                        bb= BollingerBands(df)
                        bb_signal=bb.get_signals()
                
                        if bb_signal['signal']==1 or stoch_signal['signal']==1:
                            print ('-----------' + symbol + '-----------')
                            print('psar : {}'.format(psar_signal))
                            print('bb : {}'.format(bb_signal))
                            print('stoch: {}'.format(stoch_signal))

                            #sleep(0.1)
                    except Exception as e:
                        # Handle other types of exceptions
                        print(f"An error occurred: {e}")
                        continue

                    finally:
                        continue
                print(str(datetime.now()) + ' : ')
                print('============================loop done =====================')