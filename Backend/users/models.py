from django.db import models
from courses.models import Course

# Create your models here.
class User(models.Model):
    name = models.CharField(max_length=64)
    netid = models.CharField(max_length=64)

class User_Courses(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="courses")
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="users")