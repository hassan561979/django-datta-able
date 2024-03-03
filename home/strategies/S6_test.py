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


class MyStrategy(bt.Strategy):

    params = (
        ("ema_period", 200),
        ("psar_af", 0.02),
        ("psar_max_af", 0.2),
        ("bbands_period", 10),
        ("bbands_dev", 2),
        ("stochastic_period", 14),
        ("stochastic_d_period", 3),
        ("atr_period", 14),
        ("stop_loss_percent", None),  # 1.0% stop-loss
        ("FearGreedDf", None),
        ("rsi_threshold", 50),
        ("rsi_period", 14),
        ("atr_period", 14),  # Adjust ATR period as needed
        ("volatility_threshold", 0.1),  # Set the volatility threshold to 50%


    )

    def __init__(self):
        self.stop_loss_percent = self.params.stop_loss_percent
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
        # self.atr = bt.indicators.AverageTrueRange(
        #    period=self.params.atr_period)
        # self.rsi = bt.indicators.RelativeStrengthIndex(
        #    period=self.params.rsi_period
        # )

        # Add ATR indicator
        # self.atr = bt.indicators.AverageTrueRange(
        #    period=self.params.atr_period)

        self.bought = False
        self.last_date = None

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

        # Get the current volatility (ATR)
        # current_volatility = self.atr.lines.atr[0]
        # print('current volatility:' + str(current_volatility))
        # print('coin volatility:' +
        #      str(self.params.volatility_threshold * self.data.close))

        if self.position.size > 0 and self.data.close <= self.stop_loss_price:

            self.close()

            print('stop loss sell: ' + str(self.data.close[0]))

        # elif (self.position.size <= 0 and self.data.low > self.ema
        elif (self.position.size <= 0 and self.data.low > self.ema
              and prev_close < self.bbands.lines.bot[-1]
              and current_high > current_open):

            self.buy()

            self.stop_loss_price = self.data.close * \
                (1 - (self.params.stop_loss_percent / 100))

            # self.stop_loss_price = self.data.close[0] - \
            #    (self.atr[0] * self.params.stop_loss_percent)

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
    def __init__(self, exchange='binance', symbol='DOT/USDT', start_date='2024-01-01', end_date='2024-01-17', timeframe='30m', initial_balance=100, stop_loss_percent=1, maker_fee=None, taker_fee=None, plot=False, FearGreedDf=None):
        self.exchange = exchange
        self.symbol = symbol
        self.start_date = start_date
        self.end_date = end_date
        self.timeframe = timeframe
        self.initial_balance = initial_balance
        self.stop_loss_percent = stop_loss_percent
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
            MyStrategy, stop_loss_percent=self.stop_loss_percent, FearGreedDf=self.FearGreedDf)

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
    # start_date = '2023-10-25'  # Your start date // very bearish
    # end_date = '2024-02-14'    # Your end date

    # balance 110
    # frame     30m
    # coins         100     100     10  10  10  10  10  10
    # stop loss 2   80     1204    134  98  181 138 194 46
    # stop loss 4   148     173    143  200 149 141 106 125
    # stop loss 6   940     3895   298  385 150 102 288 125
    # stop loss 8   20196   83472  154  205 157 194 168 102
    # stop loss 10  2679    1249   209  131 123 151 35  130
    # stop loss 12  28577   7691   172  65  129 222 287 239
    # stop loss 14  14855   16481  148  105 301 241 150 141
    # stop loss 16  1170    55707  176  520 157 256 127 198
