import requests
import pandas as pd


def fetch_current_fear_greed():
    # fear_greed_api_url = 'https://api.alternative.me/fng/?limit=0' // getting all days fear greedy
    fear_greed_api_url = 'https://api.alternative.me/fng/?limit=1'
    response = requests.get(fear_greed_api_url)

    if response.status_code == 200:
        data = response.json().get('data', [])
        if data:
            current_fear_greed = data[0]
            current_fear_greed['timestamp'] = pd.to_datetime(
                current_fear_greed['timestamp'], unit='s')
            return pd.DataFrame([current_fear_greed]).set_index('timestamp')
        else:
            print("No data available.")
            return None
    else:
        print(f"Error fetching data. Status code: {response.status_code}")
        return None
