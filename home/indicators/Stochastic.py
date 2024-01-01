import pandas as pd
import pandas_ta as ta
from ExchangeConnector import ExchangeConnector
from PandasUtil import PandasUtil as pu;
from time import sleep
from datetime import datetime
import os

class Stochastic:
    def __init__(self, data, k_period=14, d_period=3, overbought=80, oversold=20):
        self.data = data
        self.k_period = k_period
        self.d_period = d_period
        self.overbought = overbought
        self.oversold = oversold
        self.generate_signals()

    def generate_signals(self):
        # Fetch historical data
              
        aa = ta.stoch(self.data['high'], self.data['low'], self.data['close'], k=self.k_period,d=self.d_period,smooth_k= 3)
        print(aa)
        os._exit(1)
        
        # Calculate Stochastic Oscillator
        data['stoch_k'], data['stoch_d'] = ta.stoch(data['high'], data['low'], data['close'], k=self.k_period, d=self.d_period)

        # Generate signals
        data['signal'] = 0  # 0: Hold, 1: Buy, -1: Sell

        # Buy signal: Stoch K crosses above Stoch D in oversold territory
        data.loc[(data['stoch_k'] > data['stoch_d']) & (data['stoch_d'] < self.oversold), 'signal'] = 1

        # Sell signal: Stoch K crosses below Stoch D in overbought territory
        data.loc[(data['stoch_k'] < data['stoch_d']) & (data['stoch_d'] > self.overbought), 'signal'] = -1

        self.signals = data[['close', 'stoch_k', 'stoch_d', 'signal']]

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
                stoch = Stochastic(df,14,3)

                # Get the signals DataFrame
                signals = stoch.get_signals()
                #if signals ==-1 or signals==1:
                print ('-----------' + symbol + '-----------')
                print(signals)