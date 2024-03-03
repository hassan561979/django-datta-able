from home.PandasUtil import PandasUtil as pu
from home.indicators.Stoch import Stoch
from home.indicators.Psar import Psar
from home.indicators.AwesomeBBands import AwesomeBBands
import os
from home.indicators.Ema import Ema


class S10:
    def __init__(self, exchange, symbol, time_frame, order_type):
        self.exchange = exchange
        self.symbol = symbol
        self.time_frame = time_frame
        self.order_type = order_type
        self.generate_signals()

    def generate_signals(self):
        ohlcv = self.exchange.fetch_ohlcv(self.symbol, self.time_frame)

        df = pu.create_data_frame(ohlcv)
        signals = {'signal': 0, 'log': ''}

        if self.order_type == -1:  # sell
            bb = AwesomeBBands(df, self.exchange, self.symbol, window=20)
            bb_signal = bb.get_signals()

            stoch = Stoch(df)
            stoch_signal = stoch.get_signals()

            if bb_signal['signal'] == -1 or stoch_signal['signal'] == -1:
                signals = {'signal': -1,
                           'log': 'bb: {}'.format(bb_signal) + ', stoch: {}'.format(stoch_signal)}

        elif self.order_type == 1:  # buy
            ema = Ema(df, self.symbol, 200)
            ema_signal = ema.get_signals()
            signals = {'signal': 0, 'log': 'ema_200: {}'.format(
                ema_signal['signal'])}

            if ema_signal['signal'] == 1:
                bb = AwesomeBBands(df, self.exchange, self.symbol, window=20)
                bb_signal = bb.get_signals()
                stoch = Stoch(df)
                stoch_signal = stoch.get_signals()

                if bb_signal['signal'] == 1 and stoch_signal['signal'] == 1:
                    signals = {'signal': 1,
                               'log': 'bb: {}'.format(bb_signal) + ', stoch: {}'.format(stoch_signal)}
                else:
                    signals = {
                        'signal': 0, 'log': 'bb: {}'.format(bb_signal) + ', stoch: {}'.format(stoch_signal)}

        self.signals = signals

    def get_signals(self):
        return self.signals
