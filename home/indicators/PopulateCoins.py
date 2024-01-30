import os
from home.models import Coin


class PopulateCoins():
    def getCoins(exchange):

        markets = exchange.fetch_markets()
        execluded = ['BTCDOMUSDT', 'USDPUSDT',
                     'DOWNUSDT''TUSDUSDT', 'USDCUSDT', 'UPUSDT']
        # Extract available trading pairs with USDT as the quote currency
        for market in markets:
            # Check if trading is allowed (you can buy and sell)
            if market['info'].get('status', '').lower() == 'trading':
                # Check if the quote currency is USDT
                if market['info']['quoteAsset'].lower() == 'usdt':
                    symbol = market['info']['symbol']
                    if not any(element in symbol for element in execluded) and symbol[-1].isdigit() == False:
                        symbol_exists = Coin.objects.filter(
                            symbol=symbol).exists()

                        if symbol_exists == False:
                            coin = Coin()
                            coin.name = symbol
                            coin.symbol = symbol
                            coin.status = 1
                            coin.save()
