from home.indicators.ATR import ATR
from home.PandasUtil import PandasUtil as pu


class StopLoss:

    def __init__(self, buy_order, exchange) -> None:
        self.buy_order = buy_order
        self.exchange = exchange

    def checkStopLoss(self):

        ticker = self.exchange.fetch_ticker(self.buy_order.coin.symbol)
        current_price = ticker['last']
        if current_price < self.buy_order.calc_stop_loss:
            return True
        else:
            return False

    def calc_atr_stop_loss(self):
        ohlcv = self.exchange.fetch_ohlcv(
            self.buy_order.coin.symbol, self.buy_order.time_frame.time_frame)

        df = pu.create_data_frame(ohlcv)

        atr = ATR(data=df, symbol=self.buy_order.coin.symbol)
        atr_value = atr.getValue()

        ticker = self.exchange.fetch_ticker(self.buy_order.coin.symbol)
        current_price = ticker['last']
        stop_los_factor = self.buy_order.time_frame.stop_loss_percent
        stop_loss_price = self.buy_order.buy_price - \
            (stop_los_factor * atr_value)

        if current_price < stop_loss_price:
            return -1, stop_loss_price
        else:
            return 0, stop_loss_price
