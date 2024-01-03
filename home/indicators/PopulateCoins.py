from home.ExchangeConnector import ExchangeConnector
class PopulateCoins():
    def getCoins(exchange):
    # Load all available spot markets
        spot_markets = exchange.load_markets()

    # Extract base and quote assets from each spot trading pair with USDT
        spot_usdt_coin_names = set()
        for symbol in spot_markets:
            if 'spot' in spot_markets[symbol]['type'] and spot_markets[symbol]['quote'] == 'USDT':
                base = spot_markets[symbol]['base']
                spot_usdt_coin_names.add(base)

        coins = set()
        # Print all spot USDT coin names
        for coin in spot_usdt_coin_names:
            if coin !='USDT' or coin !='BUSD' or coin !='FBUSD' or coin !='TUSD':
                coin = str(coin).replace('DOWN','')
                coin = str(coin).replace('BEAR','')
                coin = str(coin).replace('UP','')
                coin = str(coin).replace('BULL','')
                coin=coin + 'USDT'

                if coin not in coins and coin !='' or len(coin) > 1:
                    coins.add(coin)
        
        return coins
            
        