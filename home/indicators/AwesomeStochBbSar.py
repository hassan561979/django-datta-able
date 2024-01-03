
from ExchangeConnector import ExchangeConnector
from PopulateCoins import getCoins
from datetime import datetime
from time import sleep
import pandas as pd
from PandasUtil import PandasUtil as pu;
from AwesomeStoch import AwesomeStoch
from Psar import Psar
from BollingerBands import BollingerBands

class AwesomeStochBbSar:

    exchange = ExchangeConnector("binance")
  
    #symbols = ['BTCUSDT','HOT/USDT','SOL/USDT','MOVR/USDT','BNB/USDT','ETH/USDT']
    #symbols = ['API3USDT']
    symbols = getCoins(exchange)
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
               
                    if bb_signal['signal']==1 and stoch_signal['signal']==1:
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