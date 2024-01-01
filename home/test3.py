import pandas as pd
import pandas_ta as ta
import ccxt
import matplotlib.pyplot as plt

def fetch_binance_data(symbol, timeframe, limit=100):
    exchange = ccxt.binance({
        'apiKey': 'eIuGTra6Dyra3DLtn6cp3QymlBraxnXcBEcLmAcAYJJZTXLvEoupU3srQcLSOWlc',
        'secret': 'kqUczsrrcRFyDsPDb2DK2kcwjEaxhfQWosue0QKuFKyo0TAIrXRTuE0OHcpbQ0YB',
    })
   # exchange.set_sandbox_mode(True)

    ohlcv = exchange.fetch_ohlcv(symbol, timeframe, limit=limit)
    df = pd.DataFrame(ohlcv, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])
    df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')
    df.set_index('timestamp', inplace=True)
    return df

# Function to generate Super Trend signals with multiple atr_multipliers and periods
def generate_super_trend_signals(data, atr_multipliers=[1.5, 2.0, 2.5], periods=[7, 14, 21]):
    for atr_multiplier in atr_multipliers:
        for period in periods:
            data.ta.supertrend(length=period, multiplier=atr_multiplier, append=True, colprefix=f'SUPERT_{period}_{atr_multiplier}')

    # Combine buy and sell signals from all Super Trend indicators
    buy_conditions = [data[f'SUPERT_{period}_{atr_multiplier}_b'] for atr_multiplier in atr_multipliers for period in periods]
    sell_conditions = [data[f'SUPERT_{period}_{atr_multiplier}_s'] for atr_multiplier in atr_multipliers for period in periods]

    data['Buy_Signal'] = pd.concat(buy_conditions, axis=1).any(axis=1)
    data['Sell_Signal'] = pd.concat(sell_conditions, axis=1).any(axis=1)

# Example usage
if __name__ == "__main__":
    # Replace 'BTC/USDT' with the desired trading pair
    symbol = 'BTC/USDT'
    # Replace '1h' with the desired timeframe (e.g., '1h', '4h', '1d')
    timeframe = '1h'
    # Number of candles to fetch
    limit = 100

    # Fetch Binance data
    data = fetch_binance_data(symbol, timeframe, limit)

    # Generate Super Trend signals
    generate_super_trend_signals(data, atr_multipliers=[1.5, 2.0, 2.5], periods=[7, 14, 21])

    # Display the original and Super Trend data
    print("Original Candlestick Data:")
    print(data.head())

    # Plot the closing price along with Buy and Sell signals
    plt.figure(figsize=(12, 6))
    plt.plot(data['close'], label='Close Price', alpha=0.7)
    plt.scatter(data.index[data['Buy_Signal']], data['close'][data['Buy_Signal']],
                label='Buy Signal', marker='^', color='g')
    plt.scatter(data.index[data['Sell_Signal']], data['close'][data['Sell_Signal']],
                label='Sell Signal', marker='v', color='r')
    plt.title(f'Binance Super Trend Buy/Sell Signals - {symbol} - {timeframe}')
    plt.xlabel('Timestamp')
    plt.ylabel('Close Price')
    plt.legend()
    plt.show()