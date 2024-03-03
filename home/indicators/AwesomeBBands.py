import pandas as pd
import pandas_ta as ta
from home.ExchangeConnector import ExchangeConnector
from home.PandasUtil import PandasUtil as pu
from time import sleep
from datetime import datetime
import os


class AwesomeBBands:
    def __init__(self, data, exchange, symbol, window, num_std_dev=2.0):
        self.data = data
        self.exchange = exchange
        self.symbol = symbol
        self.window = window
        self.num_std_dev = num_std_dev
        self.generate_signals()

    def generate_signals(self):

        df = self.data.copy()
        df['rolling_mean'] = df['close'].rolling(window=self.window).mean()
        df['rolling_std'] = df['close'].rolling(window=self.window).std()

        # Calculate Bollinger Bands
        df['bb_upper'] = df['rolling_mean'] + \
            (self.num_std_dev * df['rolling_std'])
        df['bb_lower'] = df['rolling_mean'] - \
            (self.num_std_dev * df['rolling_std'])

        # self.data['bb_upper'] = ta.bbands(self.data['close'], length=self.window, std=self.num_std_dev)[
        #    'BBU_{}_{}'.format(self.window, self.num_std_dev)]
        # self.data['bb_lower'] = ta.bbands(self.data['close'], length=self.window, std=self.num_std_dev)[
        #    'BBL_{}_{}'.format(self.window, self.num_std_dev)]

        # Generate signals
        ticker = self.exchange.fetch_ticker(self.symbol)
        current_price = ticker['last']
        closed_price = df['close'].iloc[-1]
        high_price = df['high'].iloc[-1]
        prev_closed_price = df['close'].iloc[-2]
        bb_upper = df['bb_upper'].iloc[-1]
        bb_lower = df['bb_lower'].iloc[-1]
        bb_prev_lower = df['bb_lower'].iloc[-2]

        if high_price > bb_upper or current_price > bb_upper:
            signal = -1
        elif prev_closed_price < bb_prev_lower:
            signal = 1
        else:
            signal = 0

        self.signals = {'high_price': high_price, 'current_price': current_price, 'prev_closed_price': prev_closed_price, 'bb_upper': bb_upper,
                        'bb_lower': bb_lower, 'signal': signal}

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
    # symbols = ['BTCUSDT', 'HOT/USDT', 'SOL/USDT',
    #           'MOVR/USDT', 'BNB/USDT', 'ETH/USDT']

    symbols = ['DENTUSDT']

    print(str(datetime.now()) + ' : ')
    # for x in range(200):
    sleep(2)
    for symbol in symbols:
        ohlcv = exchange.fetch_ohlcv(symbol, "5m")

        df = pu.create_data_frame(ohlcv)
        # Instantiate the BollingerBandsStrategy class
        bb = AwesomeBBands(df)

        # Get the signals DataFrame
        signals = bb.get_signals()
        # if signals ==-1 or signals==1:
        print('-----------' + symbol + '-----------')
        print(str(datetime.now()) + ' : ' + str(signals))
