from django.shortcuts import render
import ccxt
import pandas as pd
import pandas_ta as ta
import backtrader as bt
import matplotlib.pyplot as plt
import pandas as pd
import os


class MyStrategy(bt.Strategy):
    params = (
        ("ema_period", 200),
        ("psar_af", 0.02),
        ("psar_max_af", 0.02),
        ("bbands_period", 10),
        ("bbands_dev", 2),
        ("stochastic_period", 14),
        ("stochastic_d_period", 3),
        ("stop_loss_percent", 5.0),  # 1.0% stop-loss

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
            # print('sell: ' + str(self.buy_flag) +
            #      ',' + str(self.data.close[0]))

        elif self.buy_flag == 1:
            if self.data.close <= self.stop_loss:
                self.buy_flag = 0
                self.sell()
                # print('sell stop loss: ' + str(self.stop_loss))

        elif self.buy_flag == 0 and (self.data.close > self.ema and self.data.close > self.psar and (self.data.close < self.bbands.lines.bot or (self.stochastic.lines.percK < 20 and self.stochastic.lines.percK > self.stochastic.lines.percD))):
            # elif self.buy_flag == 0 and (self.data.close < self.bbands.lines.bot or (self.stochastic.lines.percK < 20 and self.stochastic.lines.percK > self.stochastic.lines.percD)):
            self.buy()
            self.buy_price = self.data.close
            # print('buy : ' + str(self.data.close[0]))
            price_percent = self.buy_price * self.params.stop_loss_percent / 100
            self.stop_loss = self.buy_price - price_percent
            # print('stop loss : ' + str(self.stop_loss))
            self.buy_flag = 1


class BacktestView:
    def __init__(self, exchange='binance', symbol='DOT/USDT', start_date='2024-01-01', end_date='2024-01-17', timeframe='30m', initial_balance=100):
        self.exchange = exchange
        self.symbol = symbol
        self.start_date = start_date
        self.end_date = end_date
        self.timeframe = timeframe
        self.initial_balance = initial_balance

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
        cerebro.addstrategy(MyStrategy)

        # Set initial cash amount
        cerebro.broker.set_cash(self.initial_balance)
        # Print the starting cash amount
        print('Starting Portfolio Value: %.2f' % cerebro.broker.getvalue())

        cerebro.run()

        # print('Ending Portfolio Value: %.2f' % cerebro.broker.getvalue())

        # cerebro.plot(style='candlestick', volume=False)

        # plt.savefig('backtest_plot.png')
        # plt.show()
        return cerebro.broker.getvalue()
        # return 'Backtest completed successfully'
