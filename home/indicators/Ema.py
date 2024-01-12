import pandas as pd
import pandas_ta as ta
from home.ExchangeConnector import ExchangeConnector
from home.PandasUtil import PandasUtil as pu
from time import sleep
from datetime import datetime
import os
from home.indicators.PopulateCoins import PopulateCoins
from home.models import Coin
import os
import math


class Ema:
    def __init__(self, data, symbol, length=200):
        self.df = data
        self.symbol = symbol
        self.length = length
        self.generate_signals()

    def generate_signals(self):
        # Calculate EMA 200 using pandas_ta
        self.df['ema_200'] = ta.ema(self.df['close'], self.length)

        # Create a 'signal' column based on EMA 200 crossings
        signal = 0

        if self.df['low'].iloc[-1] > self.df['ema_200'].iloc[-1]:

            signal = 1  # Buy signal
        elif self.df['close'].iloc[-1] < self.df['ema_200'].iloc[-1]:
            signal = -1

        # df['position'] = df['signal'].diff()
        self.signals = {'low': self.df['low'].iloc[-1],
                        'ema_200': self.df['ema_200'].iloc[-1], 'signal': signal}

    def get_signals(self):
        return self.signals
