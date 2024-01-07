import ccxt
import os


class ExchangeConnector:
    def __init__(self, exchange_name, api_key=None, api_secret=None):
        self.exchange_name = exchange_name
        self.api_key = os.getenv('APIKEY', None)
        self.api_secret = os.getenv('SECRET', None)

        # Load exchange by name
        self.exchange = getattr(ccxt, exchange_name)({
            'apiKey': api_key,
            'secret': api_secret,
            # You can add other exchange-specific parameters here
        })

    def fetch_trading_fees(self):
        return self.exchange.fetch_trading_fees()

    def fetch_maker_fee(self):
        fees = self.fetch_trading_fees()
        return fees.get('maker', 0)

    def fetch_taker_fee(self):
        fees = self.fetch_trading_fees()
        return fees.get('taker', 0)

    def fetch_markets(self):
        return self.exchange.fetch_markets()

    def fetch_tickers(self):
        return self.exchange.fetch_tickers()

    def fetch_markets(self):
        return self.exchange.fetch_markets()

    def load_markets(self):
        return self.exchange.load_markets()

    def fetch_ticker(self, symbol):
        return self.exchange.fetch_ticker(symbol)

    def fetch_ohlcv(self, symbol, timeframe):
        ohlcv = self.exchange.fetch_ohlcv(symbol, timeframe)
        return ohlcv

    def fetch_balance(self):
        return self.exchange.fetch_balance()

    def create_limit_order(self, symbol, side, price, quantity):
        if side == 'buy':
            return self.exchange.create_limit_buy_order(symbol, quantity, price)
        elif side == 'sell':
            return self.exchange.create_limit_sell_order(symbol, quantity, price)

    def create_market_order(self, symbol, side, quantity):
        if side == 'buy':
            return self.exchange.create_market_buy_order(symbol, quantity)
        elif side == 'sell':
            return self.exchange.create_market_sell_order(symbol, quantity)

    def fetch_order(self, order_id, symbol=None):
        return self.exchange.fetch_order(order_id, symbol)

    def fetch_open_orders(self, symbol=None):
        return self.exchange.fetch_open_orders(symbol)

    def fetch_closed_orders(self, symbol=None, since=None, limit=None):
        return self.exchange.fetch_closed_orders(symbol, since, limit)

    def cancel_order(self, order_id, symbol=None):
        return self.exchange.cancel_order(order_id, symbol)

    # Add more methods as needed for your specific use case


# Example Usage:
if __name__ == "__main__":
    # Replace 'binance' with the name of the exchange you want to connect to
    exchange_name = 'binance'

    # Replace 'YOUR_API_KEY' and 'YOUR_API_SECRET' with your actual API key and secret
    api_key = 'YOUR_API_KEY'
    api_secret = 'YOUR_API_SECRET'

    # Create an instance of the ExchangeConnector class
    connector = ExchangeConnector(exchange_name, api_key, api_secret)

    # Fetch and print the list of available markets
    markets = connector.fetch_markets()
    print(f"Available markets on {exchange_name}:")
    for market in markets:
        print(market)

    # Fetch and print account balance
    balance = connector.fetch_balance()
    print(f"\nAccount balance on {exchange_name}:")
    print(balance)

    # Fetch and print open orders
    open_orders = connector.fetch_open_orders()
    print(f"\nOpen orders on {exchange_name}:")
    for order in open_orders:
        print(order)
