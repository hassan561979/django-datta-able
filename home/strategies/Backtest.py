from django.shortcuts import render
import ccxt
import pandas as pd
import pandas_ta as ta
import backtrader as bt
import matplotlib.pyplot as plt
import pandas as pd
import os
import yfinance as yf


class MyStrategy(bt.Strategy):
    params = (
        ("ema_period", 200),
        ("psar_af", 0.02),
        ("psar_max_af", 0.02),
        ("bbands_period", 10),
        ("bbands_dev", 2),
        ("stochastic_period", 14),
        ("stochastic_d_period", 3),
        ("stop_loss_percent", 2.0),  # 1.0% stop-loss

    )

    def __init__(self):
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
        if self.buy_flag == 1 and (self.data.close > self.bbands.lines.top or (self.stochastic.lines.percK < self.stochastic.lines.percD and self.stochastic.lines.percK > 80 and self.stochastic.lines.percD > 80)):
            self.buy_flag = 0
            self.sell()

        elif self.buy_flag == 1:
            if self.data.close <= self.sell_price:
                self.sell()
                self.buy_flag = 0

        # elif self.buy_flag == 0 and (self.data.close > self.ema and self.data.close > self.psar) and (self.data.close < self.bbands.lines.bot or (self.stochastic.lines.percK < 20 and self.stochastic.lines.percK > self.stochastic.lines.percD)):
        elif self.buy_flag == 0 and (self.data.close < self.bbands.lines.bot or (self.stochastic.lines.percK < 20 and self.stochastic.lines.percK > self.stochastic.lines.percD)):
            self.buy_flag = 1
            self.buy()
            self.buy_price = self.data.close

            price_percent = self.buy_price * self.params.stop_loss_percent / 100
            self.sell_price = self.buy_price - price_percent

    def notify_order(self, order):
        if order.status in [order.Completed, order.Canceled, order.Margin]:
            return  # Ignore completed/canceled/margin orders

        if order.status in [order.Submitted, order.Accepted]:
            return  # Ignore submitted/accepted orders

        # Check if the order was a buy or sell
        if order.isbuy():
            self.log(
                f"BUY EXECUTED - Price: {order.executed.price}, Cost: {order.executed.value}, Commission: {order.executed.comm}")
            self.sell(exectype=bt.Order.Stop, price=order.executed.price *
                      (1.0 - self.params.stop_loss_percent / 100.0))

        elif order.issell():
            self.log(
                f"SELL EXECUTED - Price: {order.executed.price}, Cost: {order.executed.value}, Commission: {order.executed.comm}")


class BacktestView:
    def __init__(self, exchange='binance', symbol='SOL/USDT', timeframe='30m', initial_balance=100000):
        self.exchange = exchange
        self.symbol = symbol
        self.timeframe = timeframe
        self.initial_balance = initial_balance

    def backtest(self):

        # ohlcv = self.exchange.fetch_ohlcv(self.symbol, self.timeframe)
        # Convert ohlcv list to DataFrame
        # df = pd.DataFrame(
        #    ohlcv, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])
        # df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')
        # df.set_index('timestamp', inplace=True)

        # df = df.tail(10000)
        symbol = 'ETH-USD'  # Yahoo Finance symbol for DOT/USDT
        timeframe = '1d'  # Daily data
        data = yf.download(symbol, start="2022-01-01",
                           end="2023-01-01", interval=timeframe)

        data = bt.feeds.PandasData(dataname=data)

        # Create cerebro engine
        cerebro = bt.Cerebro()

        cerebro.adddata(data)
        cerebro.addstrategy(MyStrategy)

        # Set initial cash amount
        cerebro.broker.set_cash(1000)
        # Print the starting cash amount
        print('Starting Portfolio Value: %.2f' % cerebro.broker.getvalue())

        # Run the strategy
        cerebro.run()

        # Print the ending cash amount
        print('Ending Portfolio Value: %.2f' % cerebro.broker.getvalue())

        # Plot the results
        cerebro.plot(style='candlestick', volume=False)

        # Save the plot to a file (optional)
        plt.savefig('backtest_plot.png')

        # Display the plot
        plt.show()

        return 'Backtest completed successfully'
