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


class ATR:
    def __init__(self, data, symbol, length=14):
        self.df = data
        self.symbol = symbol
        self.length = length
        self.getValue()

    def getValue(self):
        # Calculate ATR using pandas_ta
        self.df['atr'] = ta.atr(
            self.df['high'], self.df['low'], self.df['close'], length=self.length)

        value = self.df['atr'].iloc[-1]
        return value
