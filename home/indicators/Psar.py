import pandas as pd
import pandas_ta as ta
from ExchangeConnector import ExchangeConnector
from PandasUtil import PandasUtil as pu
from time import sleep
from datetime import datetime
import os
import math

class Psar:
    def __init__(self,data,long_or_short, initial_acceleration=0.02, acceleration_Factor=0.02, maximum_acceleration=0.02):
        self.data = data
        self.long_or_short=long_or_short
        self.initial_acceleration = initial_acceleration
        self.acceleration_Factor = acceleration_Factor
        self.maximum_acceleration = maximum_acceleration
        self.generate_signals()
        self.signals

    def generate_signals(self):
        # Fetch historical data
        data = self.data
       # Calculate Parabolic SAR
        result = ta.psar(data['high'], data['low'], data['close'],
                         self.initial_acceleration, self.acceleration_Factor, self.maximum_acceleration)
        
        PSAR=0
        
        if self.long_or_short==1: #long
            PSAR =result['PSARl_{}_{}'.format(self.initial_acceleration,self.maximum_acceleration)]
            PSAR=PSAR.iloc[-1];
            PSAR=float(PSAR)

            if math.isnan(PSAR)==False:
                if PSAR<data['close'].iloc[-1]:
                    signal=1
                elif PSAR>data['close'].iloc[-1]:
                    signal=-1
                else:
                    signal=0
            else:
                signal=0
        elif self.long_or_short==0: # short
            PSAR =result['PSARs_{}_{}'.format(self.initial_acceleration,self.maximum_acceleration)]
            PSAR=PSAR.iloc[-1];
            PSAR=float(PSAR)

            if math.isnan(PSAR)==False:
                if PSAR<data['close'].iloc[-1]:
                    signal=1
                elif PSAR>data['close'].iloc[-1]:
                    signal=-1
                else:
                    signal=0
            else:
                signal=0

            signals={'close':data['close'].iloc[-1],'psar':PSAR,'signal':signal}
    
        self.signals = signals

    
    def get_signals(self):
        return self.signals

# Example usage:
if __name__ == "__main__":
    exchange = ExchangeConnector("binance")
    # markets = exchange.load_markets()
    # symbol_names = list(markets.keys())

    # print("All Binance Trading Symbols:")
    # print(symbol_names)

    # Replace 'BTC/USDT' with your trading pair
    # symbols = ['BTCUSDT','HOT/USDT','SOL/USDT','MOVR/USDT','BNB/USDT','ETH/USDT']
    symbols = ['TRBUSDT']
    print(str(datetime.now()) + ' : ')
    for x in range(200):
        sleep(2)
        for symbol in symbols:
            ohlcv = exchange.fetch_ohlcv(symbol, "5m")
            # print(ohlcv)
            # os._exit(1)
            df = pu.create_data_frame(ohlcv)
            # Instantiate the BollingerBandsStrategy class
            psar = Psar(df,1)

            # Get the signals DataFrame
            signals = psar.get_signals()
            # if signals ==-1 or signals==1:
            print('-----------' + symbol + '-----------')
            print(signals)
