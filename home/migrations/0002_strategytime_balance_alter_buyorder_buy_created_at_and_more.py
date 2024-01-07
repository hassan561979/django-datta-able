# Generated by Django 4.1.12 on 2024-01-06 13:40

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='strategytime',
            name='balance',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='buyorder',
            name='buy_created_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 1, 6, 16, 40, 21, 482588)),
        ),
        migrations.AlterField(
            model_name='buyorder',
            name='buy_updated_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 1, 6, 16, 40, 21, 482588)),
        ),
        migrations.AlterField(
            model_name='coin',
            name='created_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 1, 6, 16, 40, 21, 481590)),
        ),
        migrations.AlterField(
            model_name='coin',
            name='updated_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 1, 6, 16, 40, 21, 481590)),
        ),
        migrations.AlterField(
            model_name='sellorder',
            name='sell_created_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 1, 6, 16, 40, 21, 483626)),
        ),
        migrations.AlterField(
            model_name='sellorder',
            name='sell_updated_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 1, 6, 16, 40, 21, 483626)),
        ),
        migrations.AlterField(
            model_name='strategy',
            name='created_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 1, 6, 16, 40, 21, 481590)),
        ),
        migrations.AlterField(
            model_name='strategy',
            name='updated_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 1, 6, 16, 40, 21, 481590)),
        ),
        migrations.AlterField(
            model_name='strategytime',
            name='created_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 1, 6, 16, 40, 21, 482588)),
        ),
        migrations.AlterField(
            model_name='strategytime',
            name='updated_at',
            field=models.DateTimeField(default=datetime.datetime(2024, 1, 6, 16, 40, 21, 482588)),
        ),
    ]
