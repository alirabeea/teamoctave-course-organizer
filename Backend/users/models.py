from django.db import models
from django.contrib.auth.models import User as Django_User
from courses.models import Course

# Create your models here.
class User(models.Model):
    name = models.CharField(max_length=64)
    netid = models.CharField(max_length=64)
    django_user = models.OneToOneField(Django_User, on_delete= models.CASCADE, related_name="user")

    def __str__(self):
        return f"{self.django_user.username}"

class User_Course(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="courses")
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="users")

    def __str__(self):
        return f"{self.user}: {self.course}"

    class Meta:
        unique_together = ('user', 'course',)