import pandas as pd
import pandas_ta as ta
from home.ExchangeConnector import ExchangeConnector
from home.PandasUtil import PandasUtil as pu;
from time import sleep
from datetime import datetime
import os

class BollingerBands:
    def __init__(self, data, window=10, num_std_dev=2.0):
        self.data = data
        self.window = window
        self.num_std_dev = num_std_dev
        self.generate_signals()

    def generate_signals(self):
        # Calculate Bollinger Bands
        self.data['bb_upper'] = ta.bbands(self.data['close'], length=self.window, std=self.num_std_dev)['BBU_{}_{}'.format(self.window,self.num_std_dev)]
        self.data['bb_lower'] = ta.bbands(self.data['close'], length=self.window, std=self.num_std_dev)['BBL_{}_{}'.format(self.window,self.num_std_dev)]
        # Generate signals
       
        closed_price =self.data['close'].iloc[-1]
        bb_upper =self.data['bb_upper'].iloc[-1]
        bb_lower =self.data['bb_lower'].iloc[-1]

        if closed_price > bb_upper:
            signal=-1
        elif closed_price < bb_lower:
            signal=1
        else:
            signal=0
        
        self.signals = {'close':closed_price,'bb_upper':bb_upper,'bb_lower':bb_lower,'signal':signal}

            
    def get_signals(self):
        return self.signals
# Example usage:
if __name__ == "__main__":
    exchange = ExchangeConnector("binance")
    #markets = exchange.load_markets()
    #symbol_names = list(markets.keys())

    #print("All Binance Trading Symbols:")
    #print(symbol_names)

    # Replace 'BTC/USDT' with your trading pair
    symbols = ['BTCUSDT','HOT/USDT','SOL/USDT','MOVR/USDT','BNB/USDT','ETH/USDT']
    print(str(datetime.now()) + ' : ')
    for x in range(200):
            sleep(2)
            for symbol in symbols:
                ohlcv = exchange.fetch_ohlcv(symbol, "5m")
            
                df = pu.create_data_frame(ohlcv)
                # Instantiate the BollingerBandsStrategy class
                bb = BollingerBands(df)

                # Get the signals DataFrame
                signals = bb.get_signals()
                #if signals ==-1 or signals==1:
                print ('-----------' + symbol + '-----------')
                print(str(datetime.now()) + ' : ' + str(signals))