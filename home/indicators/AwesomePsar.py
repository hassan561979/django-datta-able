import pandas as pd
import pandas_ta as ta
from home.ExchangeConnector import ExchangeConnector
from home.PandasUtil import PandasUtil as pu
from time import sleep
from datetime import datetime
import os
import math


class AwesomePsar:
    def __init__(self, data, initial_acceleration=0.02, acceleration_Factor=0.02, maximum_acceleration=0.02):
        self.data = data
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

        PSARl = result['PSARl_{}_{}'.format(
            self.initial_acceleration, self.maximum_acceleration)]
        PSARl = PSARl.iloc[-1]
        PSARl = float(PSARl)

        PSARs = result['PSARs_{}_{}'.format(
            self.initial_acceleration, self.maximum_acceleration)]
        PSARs = PSARs.iloc[-1]
        PSARs = float(PSARs)

        if math.isnan(PSARl) == False:
            current_price = data['close'].iloc[-1]
            price_diff = current_price - PSARl
            diff_percent = (price_diff / current_price) * 100
            if diff_percent > 2:
                PSAR = PSARl
                signal = 1
            else:
                PSAR = 0
                signal = 0

        elif math.isnan(PSARs) == False:
            PSAR = PSARs
            signal = -1
        else:
            PSAR = 0
            signal = 0

        signals = {'close': data['close'].iloc[-1],
                   'psar': PSAR, 'signal': signal}

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
    symbols = ['API3USDT', 'TRBUSDT', 'BTCUSDT', 'HOT/USDT',
               'SOL/USDT', 'MOVR/USDT', 'BNB/USDT', 'ETH/USDT']
    # symbols = ['TRBUSDT']
    print(str(datetime.now()) + ' : ')
    for x in range(200):
        sleep(1)
        for symbol in symbols:
            ohlcv = exchange.fetch_ohlcv(symbol, "5m")
            # print(ohlcv)
            # os._exit(1)
            df = pu.create_data_frame(ohlcv)
            # Instantiate the BollingerBandsStrategy class
            psar = Psar(df)

            # Get the signals DataFrame
            signals = psar.get_signals()
            # if signals ==-1 or signals==1:
            print('-----------' + symbol + '-----------')
            print(signals)
            sleep(1)
