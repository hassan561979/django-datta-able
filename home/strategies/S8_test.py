from django.shortcuts import render
import ccxt
import pandas as pd
import pandas_ta as ta
import backtrader as bt
import matplotlib.pyplot as plt
import pandas as pd
import os
from home.indicators.RVIndicatorTest import RVIndicatorTest

from backtrader import Cerebro
import requests
import numpy as np


class MyStrategy(bt.Strategy):

    params = (
        ("ema_period", 200),
        ("psar_af", 0.02),
        ("psar_max_af", 0.2),
        ("bbands_period", 20),
        ("bbands_dev", 2),
        ("stochastic_period", 14),
        ("stochastic_d_period", 3),
        ("atr_period", 14),
        ("FearGreedDf", None),
        ("rsi_threshold", 50),
        ("rsi_period", 14),
        ("atr_period", 14),  # Adjust ATR period as needed
        ("atr_multiplier", 4),
        ("volatility_threshold", 0.1),  # Set the volatility threshold to 50%
        ("stoploss", None),

    )

    def __init__(self):
        self.stoploss = self.params.stoploss
        self.last_executed_size = 0
        self.buy_flag = 0
        self.ema = bt.indicators.ExponentialMovingAverage(
            self.data.close, period=self.params.ema_period)
        # self.psar = bt.indicators.ParabolicSAR(
        #    self.data, af=self.params.psar_af, afmax=self.params.psar_max_af)
        self.bbands = bt.indicators.BollingerBands(
            self.data.close, period=self.params.bbands_period, devfactor=self.params.bbands_dev)
        # self.stochastic = bt.indicators.Stochastic(
        #    self.data, period=self.params.stochastic_period)
        # self.rvi = RVIndicatorTest()
        self.atr = bt.indicators.AverageTrueRange(
            period=self.params.atr_period)
        # self.rsi = bt.indicators.RelativeStrengthIndex(
        #    period=self.params.rsi_period
        # )

        # Add ATR indicator
        # self.atr = bt.indicators.AverageTrueRange(
        #    period=self.params.atr_period)

        self.bought = False
        self.last_date = None

    def checkBullishPattern(self):
        # Check for famous bullish candlestick patterns
        bullish_patterns = [
            'CDLHAMMER', 'CDLINVERTEDHAMMER', 'CDLBULLISHENGULFING',
            'CDLBULLISHHARAMI', 'CDLTWEETOP', 'CDLHANGINGMAN',
            # Add more patterns as needed
        ]

        for pattern in bullish_patterns:
            if self.data.ta.cdl_pattern(pattern)[-1] == 100:
                return True

        return False

    def checkVolatility(self):
        atr_value = self.atr.lines.atr
        historical_atr_values = self.atr.lines.atr.get(
            size=self.params.atr_period)

        # Calculate a threshold based on a multiplier
        volatility_threshold_multiplier = 1.0  # Adjust as needed
        volatility_threshold = volatility_threshold_multiplier * \
            np.mean(historical_atr_values)

        if atr_value > volatility_threshold:
            return True
        else:
            return False

    def next(self):
        data_date = self.data.datetime.datetime(0).date().strftime('%Y-%m-%d')
        data_date = pd.to_datetime(data_date)
        fear_greed_value = int(self.params.FearGreedDf.loc[data_date]['value'])
        if fear_greed_value < 65:
            return

        prev_close = self.data.close[-1]
        prev_open = self.data.open[-1]
        current_high = self.data.high
        current_open = self.data.open

        if (self.position.size > 0 and self.data.close <= self.stop_loss_price):

            self.close()

            print('stop loss sell: ' + str(self.data.close[0]))

        # elif (self.position.size <= 0 and self.data.low > self.ema
        elif (self.position.size <= 0 and self.data.low > self.ema
              and prev_close < self.bbands.lines.bot[-1]
              and current_high > current_open
              and current_high > prev_close):

            self.buy()

            # Calculate the ATR value
            atr_value = self.atr.lines.atr

            # Calculate the stop-loss price using ATR multiplier
            self.stop_loss_price = self.data.close - \
                (self.stoploss * atr_value)

            self.bought = True
            print(f"fear greed index: {fear_greed_value}")
            print(f"Buy at: {self.data.datetime.datetime(0)}")
            print('current price: ' + str(self.data.close[0]))
            print('stop loss : ' + str(self.stop_loss_price))

        # elif (self.position.size > 0 and self.rsi.lines.rsi > self.params.rsi_threshold):
        elif (self.position.size > 0
              and self.data.high > self.bbands.lines.top):

            # print('sell: ' + str(self.buy_flag) +
            #      ',' + str(self.data.close[0]))
            # if self.last_buy_order:
            #    self.sell(parent=self.last_buy_order)
            print('normal sell: ' + str(self.data.close[0]))
            self.close()
            print(f"sell at: {self.data.datetime.datetime(0)}")

            # if self.last_executed_order:
            # self.sell(size=self.last_executed_size)
            # Sell all to exit the position
            # self.order_target_percent(target=0)

    def notify_order(self, order):
        # if order.status in [order.Submitted, order.Accepted]:
        # print('Portfolio Value: %.2f' % self.broker.getvalue())

        # if order.isbuy():
        #    print(f"Buy order {order.ref} submitted/accepted")
        # elif order.issell():
        #    print(f"Sell order {order.ref} submitted/accepted")

        # print('Portfolio Value: %.2f' % self.broker.getvalue())

        if order.status in [order.Completed]:
            # Order completed, do something
            print(f"Order {order.ref} {bt.Order.Status[order.status]}")
            # Order completed, print order type
            if order.isbuy():
                print(f"Buy order {order.ref} completed")
                print('BUY EXECUTED, Price: %.2f, Total Amount: %.2f, Total Coins: %.8f, Comm %.2f, Date: %s' %
                      (order.executed.price,
                          order.executed.value,
                          order.executed.size,
                          order.executed.comm,
                          bt.num2date(order.executed.dt).strftime('%Y-%m-%d %H:%M:%S')))
                # self.last_executed_size = round(
                #    self.broker.getvalue() / order.executed.price)
                # self.last_executed_size = order.executed.size

            elif order.issell():
                print(f"Sell order {order.ref} completed")
                print('SELL EXECUTED, Price: %.2f, Total Amount: %.2f, Total Coins: %.8f, Comm %.2f, Date: %s' %
                      (order.executed.price,
                          order.executed.value,
                          order.executed.size,
                          order.executed.comm,
                          bt.num2date(order.executed.dt).strftime('%Y-%m-%d %H:%M:%S')))
                self.last_date = bt.num2date(
                    order.executed.dt).strftime('%Y-%m-%d')
            # elif order.exectype == bt.Order.Stop:
            #    print('STOP LOSS EXECUTED, Price: %.2f, Cost: %.2f, Comm %.2f' %
            #          (order.executed.price,
            #              order.executed.value,
            #              order.executed.comm))

            print('Portfolio Value: %.2f' % self.broker.getvalue())

        elif order.status in [order.Canceled, order.Margin, order.Rejected]:
            # Order canceled, do something
            print(f"Order {order.ref} {bt.Order.Status[order.status]}")
            # Order canceled, print order type
            if order.isbuy():
                print(f"Buy order {order.ref} canceled")
            elif order.issell():
                print(f"Sell order {order.ref} canceled")

        print('Portfolio Value: %.2f' % self.broker.getvalue())
        print('==================================================')


class BacktestView:
    def __init__(self, exchange='binance', symbol='DOT/USDT', start_date='2024-01-01', end_date='2024-01-17', timeframe='30m', stoploss=4, initial_balance=100, maker_fee=None, taker_fee=None, plot=False, FearGreedDf=None):
        self.exchange = exchange
        self.symbol = symbol
        self.start_date = start_date
        self.end_date = end_date
        self.timeframe = timeframe
        self.stoploss = stoploss
        self.initial_balance = initial_balance
        # self.maker_fee = maker_fee
        # self.taker_fee = taker_fee
        self.plot = plot
        self.FearGreedDf = FearGreedDf

    def backtest(self):

        ohlcv = self.exchange.get_bulk_ohlcv(
            self.symbol, self.timeframe, self.start_date, self.end_date)

        # Convert ohlcv list to DataFrame
        df = pd.DataFrame(
            ohlcv, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])
        df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')
        df.set_index('timestamp', inplace=True)

        data = bt.feeds.PandasData(dataname=df)

        # Create cerebro engine
        cerebro = bt.Cerebro()

        cerebro.adddata(data)
        cerebro.addstrategy(
            MyStrategy, stoploss=self.stoploss, FearGreedDf=self.FearGreedDf)

        # Set the commission (fees)
        cerebro.broker.setcommission(
            commission=0.001)

        cerebro.broker.set_cash(self.initial_balance)
        cerebro.addsizer(bt.sizers.PercentSizer, percents=95)
        # cerebro.addsizer(FixedCashSizer)

        print('Starting Portfolio Value: %.2f' % cerebro.broker.getvalue())

        cerebro.run()

        print('Ending Portfolio Value: %.2f' % cerebro.broker.getvalue())
        if self.plot == True:
            colors = ['g' if close_price >= open_price else 'r' for open_price,
                      close_price in zip(data.open, data.close)]
            cerebro.plot(style='candlestick', volume=False,
                         plotkwargs=dict(candleColors=colors))

            plt.savefig('backtest_plot.png')
            plt.show()
        result = []
        cash = cerebro.broker.getvalue()
        strategy_instance = cerebro.runstrats[0][0]
        last_date = 0 if strategy_instance.last_date is None else strategy_instance.last_date

        result.append(cash)
        result.append(last_date)

        return result
        # return 'Backtest completed successfully'

# ===============================================================================
    # test 1
    # fear greed index > 65
    # start_date = '2023-10-25'
    # end_date = '2024-02-15'
    # balance 110
    # stop loss calced with atr muliplier 8
    # frame     30m
    # coins     20
    # profit 1  278 262 136     362 387 912 158 1203    1304    469
    # profit 2  168 330 237     242 154 382 385 126     1734    207
    # profit 3  79  642 1034    651 822 466 117 222     369     144
        # avg = 466

    #   bband 20
     # test 1
    # fear greed index > 65
    # start_date = '2023-10-25'
    # end_date = '2024-02-15'
    # balance 110
    # stop loss calced with atr muliplier 8
    # frame     30m
    # coins     20
    # profit1   362 153 172 1403    2119    286     820     435 455 207
    # profit2   899 267 471 1754    285     1355    682     131 738 360
    # profit3   457 344 470 292     271     833     2520    541 365 733
        #   avg=672
