import pandas as pd
import pandas_ta as ta
import ccxt
from PandasUtil import PandasUtil as pu;
import copy
import os
from ExchangeConnector import ExchangeConnector
from PandasUtil import PandasUtil

class SupertrendStrategy:
    def __init__(self,exchange, symbol, timeframe, limit):
        self.symbol = symbol
        self.timeframe = timeframe
        self.limit = limit
        self.exchange = exchange

    def fetch_historical_data(self):
        ohlcv = exchange.fetch_ohlcv(self.symbol, self.timeframe, self.limit)
        df = pu.create_data_frame(ohlcv)
        return df

    def calculate_supertrend(self,data,atr_multiplier,atr_window):
        data.ta.supertrend(length=atr_window, multiplier=atr_multiplier, append=True)
        print (data)
        os._exit(1)
        data['Buy_Signal'] = data['SUPERTd_{}_{}'.format(atr_window, atr_multiplier)] == 1
        data['Sell_Signal'] = data['SUPERTd_{}_{}'.format(atr_window, atr_multiplier)] == -1

    def generate_buy_sell_signals(self):
        super1_data=  self.fetch_historical_data()
        super2_data = copy.deepcopy(super1_data)
        super3_data = copy.deepcopy(super1_data)

        self.calculate_supertrend(super1_data,1.0,7)
        self.calculate_supertrend(super2_data,2.0,14)
        self.calculate_supertrend(super3_data,3.0,21)
        print ("------" + self.symbol + "------------")
        print (str(list(super1_data['Buy_Signal'])[-1]) + "," + str(list(super1_data['Sell_Signal'])[-1]))
        print (str(list(super2_data['Buy_Signal'])[-1]) + "," + str(list(super2_data['Sell_Signal'])[-1]))
        print (str(list(super3_data['Buy_Signal'])[-1]) + "," + str(list(super3_data['Sell_Signal'])[-1]))
        signal= 'Buy' if list(super3_data['Buy_Signal'])[-1] ==True and list(super2_data['Buy_Signal'])[-1]==True and list(super1_data['Buy_Signal'])[-1] ==True else "Sell"
        print(signal)
        #return signal


# Example Usage:
if __name__ == "__main__":
     
    exchange = ExchangeConnector("binance")
     
    # Replace 'BTC/USDT' with your trading pair
    symbols = ['BTCUSDT','HOT/USDT','SOL/USDT','MOVR/USDT','BNB/USDT','ETH/USDT']

for symbol in symbols:
    trading_strategy = SupertrendStrategy(
    exchange,symbol=symbol, timeframe='15m', limit=100)

    # Generate Buy/Sell Signals based on Supertrend
    singal = trading_strategy.generate_buy_sell_signals()

    # Print the updated dataframe with added Supertrend and signals
    #print(singal)
