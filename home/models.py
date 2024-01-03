from django.db import models
from datetime import datetime
# Create your models here.

class Product(models.Model):
    id    = models.AutoField(primary_key=True)
    name  = models.CharField(max_length = 100) 
    info  = models.CharField(max_length = 100, default = '')
    price = models.IntegerField(blank=True, null=True)

    def __str__(self):
        return self.name
    
class Coin(models.Model):
    id    = models.AutoField(primary_key=True)
    name  = models.CharField(max_length = 100) 
    symbol  = models.CharField(max_length = 30) 
    price = models.FloatField(blank=True, null=True)
    amount = models.FloatField(blank=True, null=True)
    available = models.FloatField(blank=True, null=True)
    periority = models.BooleanField(blank=True, null=True)
    status = models.BooleanField(blank=True, null=True)
    created_at = models.DateTimeField(default=datetime.now())
    updated_at = models.DateTimeField(default=datetime.now())

    def __str__(self):
        return self.symbol
    class Meta:
        db_table = 'Coin'
        
class BuyOrder(models.Model):
    coin = models.ForeignKey(Coin, on_delete=models.CASCADE, related_name='buy_orders')
    id    = models.AutoField(primary_key=True)
    buy_price = models.FloatField()
    buy_amount = models.FloatField()
    buy_total = models.FloatField()
    indicators = models.CharField(max_length=255,blank=True, null=True)
    buy_created_at = models.DateTimeField(default=datetime.now())
    buy_updated_at = models.DateTimeField(default=datetime.now())
    
    def __str__(self):
        return f"Buy Order {self.id}"
    class Meta:
        db_table = 'buy_orders'
class SellOrder(models.Model):
    coin = models.ForeignKey(Coin, on_delete=models.CASCADE, related_name='sell_orders')
    buy_order = models.OneToOneField(BuyOrder, on_delete=models.CASCADE, related_name='sell_order', null=True, blank=True)
    id    = models.AutoField(primary_key=True)
    sell_price = models.FloatField()
    sell_amount = models.FloatField()
    sell_total = models.FloatField()
    profit = models.FloatField()
    indicators = models.CharField(max_length=255,blank=True, null=True)
    sell_created_at = models.DateTimeField(default=datetime.now())
    sell_updated_at = models.DateTimeField(default=datetime.now())
    
    def __str__(self):
        return f"Sell Order for {self.buy_order}"
    class Meta:
        db_table = 'sell_orders'