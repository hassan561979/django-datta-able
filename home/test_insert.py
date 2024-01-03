# Insert example in views.py or a script
import os

from .models import Coin
if __name__ == "__main__":

    def insert():
        # Create a new Coin instance
        new_coin = Coin(name='Bitcoin', symbol='BTC', price=50000.0)
        new_coin.save()

        # Retrieve the Coin from the database
        retrieved_coin = Coin.objects.get(symbol='BTC')

        # Print the retrieved Coin
       # print(f"Coin Name: {retrieved_coin.name}, Symbol: {retrieved_coin.symbol}, Current Price: {retrieved_coin.price}