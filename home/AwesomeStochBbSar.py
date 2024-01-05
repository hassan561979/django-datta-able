from home.PandasUtil import PandasUtil as pu
from home.indicators.AwesomeStoch import AwesomeStoch
from home.indicators.Psar import Psar
from home.indicators.BollingerBands import BollingerBands
import os


class AwesomeStochBbSar:
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
            bb = BollingerBands(df)
            bb_signal = bb.get_signals()
            if bb_signal['signal'] == -1:
                signals = {'signal': -1, 'log': 'bb: {}'.format(bb_signal)}
            else:
                stoch = AwesomeStoch(df)
                stoch_signal = stoch.get_signals()
                if stoch_signal['signal'] == -1:
                    signals = {'signal': -1,
                               'log': 'awesome_stoch: {}'.format(stoch_signal)}

        elif self.order_type == 1:  # buy
            psar = Psar(df)
            psar_signal = psar.get_signals()
            if psar_signal['signal'] == 1:
                bb = BollingerBands(df)
                bb_signal = bb.get_signals()
                if bb_signal['signal'] == 1:
                    signals = {'signal': 1, 'log': 'bb: {}'.format(bb_signal)}
                else:
                    stoch = AwesomeStoch(df)
                    stoch_signal = stoch.get_signals()
                    if stoch_signal['signal'] == 1:
                        signals = {
                            'signal': 1, 'log': 'awesome_stoch: {}'.format(stoch_signal)}

        self.signals = signals

    def get_signals(self):
        return self.signals
