from django.core.management.base import BaseCommand
from home.ExchangeConnector import ExchangeConnector
from home.strategies.Backtest import BacktestView


class Command(BaseCommand):
    help = 'run strategies'

    # exchnage = ExchangeConnector('binance')
    backtest_view = BacktestView()
    result = backtest_view.backtest()
