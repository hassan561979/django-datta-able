import backtrader as bt
import datetime
import os


class RVIndicatorTest(bt.Indicator):
    lines = ('rvi',)

    def __init__(self):
        # Ensure at least 2 periods are available for calculation
        self.addminperiod(2)
        self.params.period = 14  # Set the period here

    def next(self):
        closes = self.data.close.get(size=self.params.period)
        print(self.data['close'])
        os.abort()
        price_change = closes - closes[-1]

        positive_price_changes = price_change * (price_change > 0)
        negative_price_changes = -price_change * (price_change < 0)

        sum_positive = positive_price_changes.sum()
        sum_negative = negative_price_changes.sum()

        if sum_negative == 0:
            self.lines.rvi[0] = 100  # Avoid division by zero
        else:
            relative_volatility = sum_positive / sum_negative
            self.lines.rvi[0] = 100 - (100 / (1 + relative_volatility))
