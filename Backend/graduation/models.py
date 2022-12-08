from django.db import models
from courses.models import Course

# Create your models here.
class Major(models.Model):
    name = models.CharField(max_length=64) # Text Field, max_length attribute required
    department = models.CharField(max_length=64)

    def __str__(self):
        return f"{self.name}"

class Requirement(models.Model):
    major = models.ForeignKey(Major, on_delete=models.CASCADE, related_name="requirements") # on_delete and related_name are compulsory.
    # Example usage:
    # comp_sci = Major(name="Computer Science", department="CICS")
    # print(comp_sci) # This will print <Major: "Computer Science">
    # requirements = comp_sci.requirements
    description = models.CharField(max_length=64)
    number_courses = models.IntegerField()
    
    def __str__(self):
        return f"{self.major} - {self.description}"

class Requirement_Course(models.Model):
    requirement = models.ForeignKey(Requirement, on_delete=models.CASCADE, related_name="courses")
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="requirements")

    def __str__(self):
        return f"{self.requirement}: {self.course}"

    # This table is optional. Same thing can be achieved using models.ManyToManyField
