from graduation.models import *
from courses.models import *
import csv

def add(requirement):
    req = Requirement(
            major_id = 1,
            description = requirement['Graduation Requirement'],
            number_courses = requirement['Course Quantity']
        )
    req.save()

    courses = requirement["Courses Satisfying"].split(",")
    for course in courses:
        course = course.strip()
        print(course)
        req_course = Requirement_Course(
            requirement = req,
            course = Course.objects.get(verbose = course)
        )
        req_course.save()

    


with open('requirements.csv') as csvfile:
    requirements = csv.DictReader(csvfile, delimiter=",")
    for requirement in requirements:
        add(requirement)
