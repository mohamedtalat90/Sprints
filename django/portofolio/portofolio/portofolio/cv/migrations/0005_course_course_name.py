# Generated by Django 3.2.19 on 2023-05-14 10:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cv', '0004_remove_course_course_name'),
    ]

    operations = [
        migrations.AddField(
            model_name='course',
            name='course_name',
            field=models.CharField(default=2, max_length=255),
            preserve_default=False,
        ),
    ]
