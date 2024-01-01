import pandas as pd
import pandas_ta as ta

class TechnicalIndicators:
    def __init__(self, data):
        self.data = data

    def calculate_sma(self, column, window):
        return ta.sma(self.data[column], window=window)

    def calculate_ema(self, column, span):
        return ta.ema(self.data[column], span=span)

    def calculate_rsi(self, column, window):
        return ta.rsi(self.data[column], window=window)

    def calculate_macd(self, column, fast=12, slow=26, signal=9):
        _, _, macd_signal = ta.macd(self.data[column], fast=fast, slow=slow, signal=signal)
        return macd_signal

    def calculate_bollinger_bands(self, column, window, std):
        _, _, upper_band = ta.bbands(self.data[column], window=window, std=std)
        return upper_band

    def calculate_atr(self, high, low, close, window):
        return ta.atr(high, low, close, window=window)

    def calculate_supertrend(self, high, low, close, atr_window=14, multiplier=1.0):
        return ta.supertrend(high, low, close, atr_window, multiplier)

    # Add more indicator calculation functions as needed

    def generate_buy_sell_signals(self):
        # Example: Generate Buy/Sell Signals based on SMA crossover
        self.data['SMA_20'] = self.calculate_sma('close', window=20)
        self.data['SMA_50'] = self.calculate_sma('close', window=50)
        self.data['Buy_Signal'] = (self.data['SMA_20'] > self.data['SMA_50']) & (self.data['SMA_20'].shift(1) <= self.data['SMA_50'].shift(1))
        self.data['Sell_Signal'] = (self.data['SMA_20'] < self.data['SMA_50']) & (self.data['SMA_20'].shift(1) >= self.data['SMA_50'].shift(1))

# Example Usage:
if __name__ == "__main__":
    # Replace 'your_data.csv' with the path to your financial data file
    data = pd.read_csv('your_data.csv')

    # Replace 'close', 'high', 'low' with the appropriate column names in your data
    indicator_calculator = TechnicalIndicators(data)

    # Example: Calculate and print the Supertrend values
    supertrend_values = indicator_calculator.calculate_supertrend('high', 'low', 'close', atr_window=14, multiplier=1.0)
    print(supertrend_values)

    # Example: Generate Buy/Sell Signals based on SMA crossover
    indicator_calculator.generate_buy_sell_signals()

    # Print the updated dataframe with added indicators and signals
    print(data.head())