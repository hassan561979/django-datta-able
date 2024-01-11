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
