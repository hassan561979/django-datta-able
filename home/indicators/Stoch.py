import pandas as pd
import pandas_ta as ta
from home.ExchangeConnector import ExchangeConnector
from home.PandasUtil import PandasUtil as pu
from time import sleep
from datetime import datetime
import os
from home.indicators.PopulateCoins import PopulateCoins


class Stoch:
    def __init__(self, data, stoch_k=14, stoch_d=3, smooth_k=3, stoch_overbought=80, stoch_oversold=20):
        self.data = data
        self.stoch_k = stoch_k
        self.stoch_d = stoch_d
        self.smooth_k = smooth_k
        self.stoch_overbought = stoch_overbought
        self.stoch_oversold = stoch_oversold
        self.generate_signals()

    def generate_signals(self):
        data = self.data
        # Calculate Stochastic Oscillator
        stoch = ta.stoch(data['high'], data['low'], data['close'],
                         k=self.stoch_k, d=self.stoch_d, smooth_k=self.smooth_k)

        # Generate signals
        stock_k = stoch['STOCHk_{}_{}_{}'.format(
            self.stoch_k, self.stoch_d, self.smooth_k)]
        stock_k = stock_k.iloc[-1]

        stock_d = stoch['STOCHd_{}_{}_{}'.format(
            self.stoch_k, self.stoch_d, self.smooth_k)]
        stock_d = stock_d.iloc[-1]

        if stock_k > stock_d:
            signal = 1
        elif stock_k > self.stoch_overbought and stock_d > self.stoch_overbought and stock_k < stock_d:
            signal = -1
        else:
            signal = 0

        self.signals = {'close': data['close'].iloc[-1],
                        'stock_k': stock_k, 'stock_d': stock_d, 'signal': signal}

    def get_signals(self):
        return self.signals


# Example usage:
if __name__ == "__main__":
    exchange = ExchangeConnector("binance")

    # symbols = ['BTCUSDT','HOT/USDT','SOL/USDT','MOVR/USDT','BNB/USDT','ETH/USDT']
    # symbols = ['API3USDT']
    symbols = PopulateCoins.getCoins(exchange)
    print(symbols)

    print(str(datetime.now()) + ' : ')
    for x in range(200):
        sleep(0.1)
        for symbol in symbols:
            try:
                ohlcv = exchange.fetch_ohlcv(symbol, "5m")

                df = pu.create_data_frame(ohlcv)
                # Instantiate the BollingerBandsStrategy class
                stoch = AwesomeStoch(df)

                # Get the signals DataFrame
                signals = stoch.get_signals()
                # if signals ==-1 or signals==1:
                if (signals['signal'] == 1):
                    print('-----------' + symbol + '-----------')
                    print(signals)
                    # sleep(0.1)
            except Exception as e:
                # Handle other types of exceptions
                print(f"An error occurred: {e}")
                continue

            finally:
                continue
        print('============================loop done =====================')
