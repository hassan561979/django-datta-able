from django.core.management.base import BaseCommand
from home.ExchangeConnector import ExchangeConnector
from datetime import datetime, timedelta


class Command(BaseCommand):
    help = 'Fetch Binance OHLCV data'

    def handle(self, *args, **options):
        symbol = 'BTC/USDT'  # Change it according to your requirements
        timeframe = '1h'  # Daily timeframe, change as needed
        start_date = '2024-01-01'  # Your start date
        end_date = '2024-01-17'    # Your end date

        echange = ExchangeConnector('binance')

        ohlcv_data = echange.get_bulk_ohlcv(
            symbol, timeframe, start_date, end_date)

        for candle in ohlcv_data:
            timestamp = datetime.utcfromtimestamp(
                candle[0] / 1000).strftime('%Y-%m-%d %H:%M:%S')
            open_price, high_price, low_price, close_price, volume = candle[1:6]
            self.stdout.write(self.style.SUCCESS(
                f"{timestamp} - O: {open_price}, H: {high_price}, L: {low_price}, C: {close_price}, V: {volume}"))

    def get_binance_ohlcv(self, symbol, timeframe, start_date, end_date):
        ohlcv = []

        since = int(datetime.strptime(
            start_date, '%Y-%m-%d').timestamp()) * 1000
        until = int(datetime.strptime(end_date, '%Y-%m-%d').timestamp()) * 1000

        while since < until:
            # Fetching OHLCV data in chunks due to Binance API limitations
            candles = echange.fetch_ohlcv(symbol, timeframe, since)
            if not candles:
                break

            ohlcv.extend(candles)
            since = candles[-1][0] + 1

        return ohlcv
