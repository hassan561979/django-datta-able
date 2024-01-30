from home.PandasUtil import PandasUtil as pu
from home.indicators.AwesomeStoch2 import AwesomeStoch2
from home.indicators.AwesomeStoch3 import AwesomeStoch3

from home.indicators.Psar import Psar
from home.indicators.BollingerBands import BollingerBands
import os
from home.indicators.Ema import Ema


class AwesomeStochBbSarEma200_3:
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
            bb = BollingerBands(df, self.exchange, self.symbol)
            bb_signal = bb.get_signals()
            if bb_signal['signal'] == -1:
                signals = {'signal': -1, 'log': 'bb: {}'.format(bb_signal)}
            else:
                stoch = AwesomeStoch2(df)
                stoch_signal = stoch.get_signals()
                if stoch_signal['signal'] == -1:
                    signals = {'signal': -1,
                               'log': 'awesome_stoch: {}'.format(stoch_signal)}

        elif self.order_type == 1:  # buy
            ema = Ema(df, self.symbol, 200)
            ema_signal = ema.get_signals()
            signals = {'signal': 0, 'log': 'ema_200: {}'.format(ema_signal)}

            if ema_signal['signal'] == 1:
                psar = Psar(df)
                psar_signal = psar.get_signals()
                if psar_signal['signal'] == 1:
                    bb = BollingerBands(df, self.exchange, self.symbol)
                    bb_signal = bb.get_signals()
                    stoch2 = AwesomeStoch2(df)
                    stoch2_signal = stoch2.get_signals()
                    stoch3 = AwesomeStoch3(df)
                    stoch3_signal = stoch3.get_signals()

                    if bb_signal['signal'] == 1 and stoch2_signal['signal'] == 1:
                        signals = {'signal': 1,
                                   'log': 'bb_stoch: {}'.format(bb_signal) + ' ema_200: {}'.format(ema_signal)}
                    elif stoch3_signal['signal'] == 1:
                        signals = {'signal': 1,
                                   'log': 'stoch3: {}'.format(stoch3_signal) + ' ema_200: {}'.format(ema_signal)}

        self.signals = signals

    def get_signals(self):
        return self.signals
