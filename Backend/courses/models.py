from django.db import models

# Create your models here.
class Course(models.Model):
    number = models.CharField(max_length=64)
    name = models.CharField(max_length=64)
    department = models.CharField(max_length=64)
    credits = models.IntegerField()
    verbose = models.CharField(max_length=64)

    def __str__(self):
        return f"{self.verbose}"

    class Meta:
        unique_together = ('number', 'department')