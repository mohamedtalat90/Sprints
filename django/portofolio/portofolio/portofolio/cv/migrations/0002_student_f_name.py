# Generated by Django 3.2.19 on 2023-05-14 10:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cv', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='student',
            name='f_name',
            field=models.CharField(default=2, max_length=255),
            preserve_default=False,
        ),
    ]
