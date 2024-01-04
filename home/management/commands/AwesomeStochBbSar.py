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
from home.indicators.AwesomeStochBbSar import AwesomeStochBbSar

from home.models import Coin
class Command(BaseCommand):
    help = 'AwesomeStochBbSar strategy'

    def handle(self, *args, **options):
        exchange = ExchangeConnector("binance")
        symbols = PopulateCoins.getCoins(exchange)

        print(str(datetime.now()) + ' : ')
        while True:
                for symbol in symbols:
                    try:
                       sleep(0.1)
                       signal=AwesomeStochBbSar(exchange,symbol,'5m',1).get_signals()
                       if signal['signal']==1:
                          print (symbol + ':{}'.format(signal))
                       
                       #signal=AwesomeStochBbSar(exchange,symbol,'5m',-1).get_signals()
                       #print (symbol + ':{}'.format(signal))
                    except Exception as e:
                        # Handle other types of exceptions
                        print(f"An error occurred: {e}")
                        continue

                    finally:
                        continue
                    
                print(str(datetime.now()) + ' : ')
                print('============================loop done =====================')