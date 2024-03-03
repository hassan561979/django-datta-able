from django.db import models
from datetime import datetime
# Create your models here.
from django.utils import timezone


class Product(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    info = models.CharField(max_length=100, default='')
    price = models.IntegerField(blank=True, null=True)

    def __str__(self):
        return self.name


class Coin(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    symbol = models.CharField(max_length=30)
    price = models.FloatField(blank=True, null=True)
    amount = models.FloatField(blank=True, null=True)
    available = models.FloatField(blank=True, null=True)
    periority = models.BooleanField(blank=True, null=True)
    status = models.BooleanField(blank=True, null=True)
    created_at = models.DateTimeField(default=timezone.now())
    updated_at = models.DateTimeField(default=timezone.now())
    strategy_profit = models.JSONField(null=True)
    market_cap = models.FloatField(blank=True, null=True)

    def __str__(self):
        return self.symbol

    class Meta:
        db_table = 'Coin'


class Strategy(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    function_name = models.CharField(max_length=255)
    balance = models.FloatField(blank=True, null=True)
    periority = models.BooleanField(blank=True, null=True)
    status = models.BooleanField(blank=True, null=True)
    created_at = models.DateTimeField(default=timezone.now())
    updated_at = models.DateTimeField(default=timezone.now())
    notes = models.TextField(blank=True, null=True)
    is_running = models.BooleanField(default=False)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'strategy'
        unique_together = (('name', 'function_name'),)


class StrategyTime(models.Model):
    id = models.AutoField(primary_key=True)
    strategy = models.ForeignKey(
        Strategy, on_delete=models.CASCADE, related_name='strategy_times')
    time_frame = models.CharField(max_length=10)
    balance = models.FloatField(blank=True, null=True)
    amount_per_order = models.FloatField(blank=True, null=True)
    periority = models.BooleanField(blank=True, null=True)
    status = models.BooleanField(blank=True, null=True)
    created_at = models.DateTimeField(default=timezone.now())
    updated_at = models.DateTimeField(default=timezone.now())
    notes = models.TextField(blank=True, null=True)
    stop_loss_percent = models.FloatField(blank=True, null=True)

    def __str__(self):
        return self.time_frame

    class Meta:
        db_table = 'strategy_times'
        unique_together = (('time_frame', 'strategy'),)


class BuyOrder(models.Model):
    id = models.AutoField(primary_key=True)
    strategy = models.ForeignKey(Strategy, on_delete=models.CASCADE)
    time_frame = models.ForeignKey(StrategyTime, on_delete=models.CASCADE)
    coin = models.ForeignKey(Coin, on_delete=models.CASCADE)
    buy_price = models.FloatField()
    buy_amount = models.FloatField()
    buy_total = models.FloatField()
    indicators = models.CharField(max_length=1000, blank=True, null=True)
    buy_created_at = models.DateTimeField(default=timezone.now())
    buy_updated_at = models.DateTimeField(default=timezone.now())

    @property
    def calc_stop_loss(self):
        price_percent = self.buy_price * \
            (self.time_frame.stop_loss_percent / 100)
        return self.buy_price - price_percent

    def __str__(self):
        return f"Buy Order {self.id}"

    class Meta:
        db_table = 'buy_orders'


class SellOrder(models.Model):
    id = models.AutoField(primary_key=True)
    strategy = models.ForeignKey(Strategy, on_delete=models.CASCADE)
    time_frame = models.ForeignKey(StrategyTime, on_delete=models.CASCADE)
    coin = models.ForeignKey(Coin, on_delete=models.CASCADE)
    buy_order = models.OneToOneField(BuyOrder, on_delete=models.CASCADE)
    sell_price = models.FloatField()
    sell_amount = models.FloatField()
    sell_total = models.FloatField()
    profit = models.FloatField()
    indicators = models.CharField(max_length=1000, blank=True, null=True)
    sell_created_at = models.DateTimeField(default=timezone.now())
    sell_updated_at = models.DateTimeField(default=timezone.now())

    def __str__(self):
        return f"Sell Order for {self.buy_order}"

    class Meta:
        db_table = 'sell_orders'


class Log(models.Model):
    id = models.AutoField(primary_key=True)
    log = models.TextField()
    created_at = models.DateTimeField(default=timezone.now())
    updated_at = models.DateTimeField(default=timezone.now())
