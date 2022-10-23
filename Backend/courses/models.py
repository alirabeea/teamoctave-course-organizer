from django.db import models

# Create your models here.
class Course(models.Model):
    number = models.CharField(max_length=64)

    def __str__(self):
        return f"{self.number}"