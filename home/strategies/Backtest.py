from django.shortcuts import render
import ccxt
import pandas as pd
import pandas_ta as ta
import backtrader as bt
import matplotlib.pyplot as plt
import pandas as pd
import os

from backtrader import Cerebro


class MyStrategy(bt.Strategy):

    params = (
        ("ema_period", 200),
        ("psar_af", 0.02),
        ("psar_max_af", 0.02),
        ("bbands_period", 10),
        ("bbands_dev", 2),
        ("stochastic_period", 14),
        ("stochastic_d_period", 3),
        ("stop_loss_percent", None),  # 1.0% stop-loss

    )

    def __init__(self):
        self.stop_loss_percent = self.params.stop_loss_percent
        self.last_executed_size = 0
        self.buy_flag = 0
        self.ema = bt.indicators.ExponentialMovingAverage(
            self.data.close, period=self.params.ema_period)
        self.psar = bt.indicators.ParabolicSAR(
            self.data, af=self.params.psar_af, afmax=self.params.psar_max_af)
        self.bbands = bt.indicators.BollingerBands(
            self.data.close, period=self.params.bbands_period, devfactor=self.params.bbands_dev)
        self.stochastic = bt.indicators.Stochastic(
            self.data, period=self.params.stochastic_period)

    def next(self):

        # elif self.buy_flag == 1:
        #    if self.data.close <= self.stop_loss:
        #        self.buy_flag = 0

        #       # print('sell stop loss: ' + str(self.stop_loss))
        #       self.sell()
        # print(self.position.size)

        if self.position.size > 0 and self.data.close <= self.stop_loss_price:
            # Place a stop-loss order
            # if self.last_buy_order:
            #    self.sell(parent=self.last_buy_order)
            self.sell()
            # self.sell(size=self.last_executed_size)
            # Sell all to exit the position
            # self.order_target_percent(target=0)

            print('stop loss sell: ' + str(self.data.close[0]))

        elif self.position.size <= 0 and self.data.low > self.ema and self.data.low > self.psar and (self.data.close < self.bbands.lines.bot or (self.stochastic.lines.percK < 20 and self.stochastic.lines.percK > self.stochastic.lines.percD)):
            # elif self.position.size <= 0 and (self.data.close < self.bbands.lines.bot or (self.stochastic.lines.percK < 20 and self.stochastic.lines.percK > self.stochastic.lines.percD)):
            # if self.position.size <= 0 and self.data.close < self.bbands.lines.bot:
            # self.order_target_value(target=self.broker.getvalue())
            # self.order_target_percent(target=100)
            self.buy()
            self.stop_loss_price = self.data.close * \
                (1 - (self.params.stop_loss_percent / 100))

            print('current price: ' + str(self.data.close[0]))
            print('stop loss : ' + str(self.stop_loss_price))

        elif self.position.size > 0 and (self.data.close > self.bbands.lines.top or (self.stochastic.lines.percK < self.stochastic.lines.percD and self.stochastic.lines.percK > 80 and self.stochastic.lines.percD > 80)):

            # print('sell: ' + str(self.buy_flag) +
            #      ',' + str(self.data.close[0]))
            # if self.last_buy_order:
            #    self.sell(parent=self.last_buy_order)
            print('normal sell: ' + str(self.data.close[0]))
            self.sell()
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
    def __init__(self, exchange='binance', symbol='DOT/USDT', start_date='2024-01-01', end_date='2024-01-17', timeframe='30m', initial_balance=100, stop_loss_percent=1, plot=False):
        self.exchange = exchange
        self.symbol = symbol
        self.start_date = start_date
        self.end_date = end_date
        self.timeframe = timeframe
        self.initial_balance = initial_balance
        self.stop_loss_percent = stop_loss_percent
        self.plot = plot

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
            MyStrategy, stop_loss_percent=self.stop_loss_percent)

        # Set the commission (fees)
        cerebro.broker.setcommission(
            commission=0.001)

        cerebro.broker.set_cash(self.initial_balance)
        cerebro.addsizer(bt.sizers.PercentSizer, percents=10)

        print('Starting Portfolio Value: %.2f' % cerebro.broker.getvalue())

        cerebro.run()

        print('Ending Portfolio Value: %.2f' % cerebro.broker.getvalue())
        if self.plot == True:
            cerebro.plot(style='candlestick', volume=False)

            plt.savefig('backtest_plot.png')
            plt.show()

        return cerebro.broker.getvalue()
        # return 'Backtest completed successfully'
