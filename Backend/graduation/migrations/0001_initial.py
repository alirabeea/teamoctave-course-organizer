# Generated by Django 4.1.2 on 2022-11-30 18:05

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('courses', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Major',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=64)),
                ('department', models.CharField(max_length=64)),
            ],
        ),
        migrations.CreateModel(
            name='Requirement',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('description', models.CharField(max_length=64)),
                ('major', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='requirements', to='graduation.major')),
            ],
        ),
        migrations.CreateModel(
            name='Requirement_Course',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('course', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='requirements', to='courses.course')),
                ('requirement', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='courses', to='graduation.requirement')),
            ],
        ),
    ]
