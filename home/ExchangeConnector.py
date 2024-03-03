import ccxt
import os
import calendar
from datetime import datetime, timedelta
from time import sleep
from django.utils import timezone
import pytz


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

        self.time_frame_limit = {"1m": 1440,
                                 "3m": 480,
                                 "5m": 288,
                                 "15m": 96,
                                 "30m": 48,
                                 "1h": 24,
                                 "2h": 12,
                                 "4h": 6,
                                 "6h": 4,
                                 "12h": 2,
                                 "1d": 1}

    def fetch_maker_fee(self):
        fees = self.exchange.fetch_trading_fees()
        return fees.get('maker', 0)

    def fetch_taker_fee(self):
        fees = self.exchange.fetch_trading_fees()
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
        # sleep(0.1)
        return self.exchange.fetch_ticker(symbol)

    def getCandlesNumbersByFrame(self, time_frame):
        frame_value = self.time_frame_limit[time_frame]
        return frame_value

    def get_bulk_ohlcv(self, symbol, timeframe, start_date, end_date):
        ohlcv = []

        since_datetime = datetime.strptime(start_date, '%Y-%m-%d')
        since_timezone = timezone.make_aware(
            since_datetime, timezone.get_default_timezone())
        since = int(since_timezone.timestamp() * 1000)

        until_datetime = datetime.strptime(
            end_date, '%Y-%m-%d')
        until_timezone = timezone.make_aware(
            until_datetime, timezone.get_default_timezone())

        until = int(until_timezone.timestamp() * 1000)
        number_of_candles = self.getCandlesNumbersByFrame(timeframe)

        while since < until:
            # Fetching OHLCV data in chunks due to Binance API limitations
            candles = self.fetch_ohlcv(
                symbol, timeframe, True, since, number_of_candles)
            if not candles:
                break

            ohlcv.extend(candles)
            since = candles[-1][0] + 1
            # print(since)
            # os.abort()
            # sleep(0.1)

        # print(ohlcv)
        # os.abort()
        return ohlcv

    def fetch_ohlcv(self, symbol, timeframe, since_flag=False, since=1704461252000, limit=500):
        # now = datetime.utcnow()
        # unixtime = calendar.timegm(now.utctimetuple())
        # since = (unixtime - 60*60) * 1000  # UTC timestamp in milliseconds

        # ohlcv = self.exchange.fetch_ohlcv(symbol, timeframe, since, limit)
        # sleep(0.1)
        if since_flag == True:
            ohlcv = self.exchange.fetch_ohlcv(symbol, timeframe, since, limit)
        else:
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
