import ccxt
import pandas as pd
import pandas_ta as ta
import matplotlib.pyplot as plt
from ExchangeConnector import ExchangeConnector

class PSARPlotter:
    def __init__(self, symbol, timeframe='5m', acceleration=0.02, maximum=0.2):
        self.symbol = symbol
        self.timeframe = timeframe
        self.acceleration = acceleration
        self.maximum = maximum
        self.exchange = ExchangeConnector("binance")  # Replace with your exchange
        self.psar_values = self.calculate_psar()

    def fetch_data(self):
        # Fetch historical OHLCV data
        ohlcv = self.exchange.fetch_ohlcv(self.symbol, self.timeframe,100)
        df = pd.DataFrame(ohlcv, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])
        df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')
        df.set_index('timestamp', inplace=True)
        return df

    def calculate_psar(self):
        # Fetch historical data
        data = self.fetch_data()

        # Calculate Parabolic SAR
        psar_values = ta.psar(data['high'], data['low'], acceleration=self.acceleration, maximum=self.maximum)

        return psar_values

    def plot_psar(self):
        # Fetch historical data
        data = self.fetch_data()

        # Plotting
        plt.figure(figsize=(10, 6))
        plt.plot(data['close'], label='Close Price', alpha=0.5)
        plt.plot(self.psar_values, label='PSAR', color='red')
        plt.title('Parabolic SAR Indicator')
        plt.xlabel('Timestamp')
        plt.ylabel('Price')
        plt.legend()
        plt.show()

# Example usage:
if __name__ == "__main__":
    symbol = 'BTC/USDT'  # Replace with the trading pair you're interested in
    psar_plotter = PSARPlotter(symbol)

    # Plot the PSAR values
    psar_plotter.plot_psar()