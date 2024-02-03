# Generated by Django 5.0.1 on 2024-02-02 00:14

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0008_alter_buyorder_buy_created_at_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='strategy',
            name='strategy_profit',
        ),
        migrations.AddField(
            model_name='coin',
            name='strategy_profit',
            field=models.JSONField(null=True),
        ),
        migrations.AlterField(
            model_name='buyorder',
            name='buy_created_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 2, 2, 0, 14, 31, 317707)),
        ),
        migrations.AlterField(
            model_name='buyorder',
            name='buy_updated_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 2, 2, 0, 14, 31, 317707)),
        ),
        migrations.AlterField(
            model_name='coin',
            name='created_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 2, 2, 0, 14, 31, 316708)),
        ),
        migrations.AlterField(
            model_name='coin',
            name='updated_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 2, 2, 0, 14, 31, 316708)),
        ),
        migrations.AlterField(
            model_name='log',
            name='created_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 2, 2, 0, 14, 31, 319708)),
        ),
        migrations.AlterField(
            model_name='log',
            name='updated_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 2, 2, 0, 14, 31, 319708)),
        ),
        migrations.AlterField(
            model_name='sellorder',
            name='sell_created_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 2, 2, 0, 14, 31, 318708)),
        ),
        migrations.AlterField(
            model_name='sellorder',
            name='sell_updated_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 2, 2, 0, 14, 31, 318708)),
        ),
        migrations.AlterField(
            model_name='strategy',
            name='created_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 2, 2, 0, 14, 31, 316708)),
        ),
        migrations.AlterField(
            model_name='strategy',
            name='updated_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 2, 2, 0, 14, 31, 316708)),
        ),
        migrations.AlterField(
            model_name='strategytime',
            name='created_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 2, 2, 0, 14, 31, 317707)),
        ),
        migrations.AlterField(
            model_name='strategytime',
            name='updated_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 2, 2, 0, 14, 31, 317707)),
        ),
    ]
