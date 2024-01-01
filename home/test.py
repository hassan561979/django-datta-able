import sys
from time import sleep
import pandas as pd
import pandas_ta as ta
import ccxt
import matplotlib.pyplot as plt
import copy
import threading
import datetime
from PandasUtil import PandasUtil

# Function to generate Super Trend signals
def generate_super_trend_signals(data, atr_multiplier=1.5, period=7):
    data.ta.supertrend(length=period, multiplier=atr_multiplier, append=True)
    data['Buy_Signal'] = data['SUPERTd_{}_{}'.format(period, atr_multiplier)] == 1
    data['Sell_Signal'] = data['SUPERTd_{}_{}'.format(period, atr_multiplier)] == -1


def getSuperTrend(symbol,timeframe,limit):
    pu = PandasUtil();
    while True:
        #try:
            sleep(5)
            # Fetch Binance data
            ohlcv = exchange.fetch_ohlcv(symbol, timeframe, limit=limit)
            data = pu.create_data_frame(ohlcv)
            data1 = copy.deepcopy(data)
            data2 = copy.deepcopy(data)

            # Generate Super Trend signals
            generate_super_trend_signals(data, atr_multiplier=1.0, period=7)
            generate_super_trend_signals(data1, atr_multiplier=2.0, period=14)
            generate_super_trend_signals(data2, atr_multiplier=3.0, period=21)

            print (list(data['Buy_Signal'])[-1])
            print (list(data1['Buy_Signal'])[-1])
            print (list(data2['Buy_Signal'])[-1])

            #signal= 'Buy' if list(data2['Buy_Signal'])[-1] ==True and list(data1['Buy_Signal'])[-1]==True and list(data['Buy_Signal'])[-1] ==True else "Sell"
            
            #print (datetime.datetime.now()," : ", symbol," : ", signal)
            #print ("----------------------------------")
        #except BaseException as e:
        #    print('error restarting thread')
        #    x=threading.Thread(target=getSuperTrend,args=(symbol,timeframe,limit))
        #    x.start()
        #    break
       
        
# Example usage
if __name__ == "__main__":
 
    exchange = ccxt.binance({
        'apiKey': 'eIuGTra6Dyra3DLtn6cp3QymlBraxnXcBEcLmAcAYJJZTXLvEoupU3srQcLSOWlc',
        'secret': 'kqUczsrrcRFyDsPDb2DK2kcwjEaxhfQWosue0QKuFKyo0TAIrXRTuE0OHcpbQ0YB',
    })

      # Replace 'BTC/USDT' with the desired trading pair
    #symbols = ['HOT/USDT','SOL/USDT','MOVR/USDT','BNB/USDT','ETH/USDT']
    symbols = ['MOVR/USDT']
    # Replace '1h' with the desired timeframe (e.g., '1h', '4h', '1d')
    timeframe = '15m'
    # Number of candles to fetch
    limit = 50

    for symbol in symbols:
        x=threading.Thread(target=getSuperTrend,args=(symbol,timeframe,limit))
        x.start()
        sleep(5)
   
   