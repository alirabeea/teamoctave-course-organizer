from courses.models import *
import csv

def add_course(requirement):
    object = Course(
            number = course['Course Number'],
            department = course['Course Subject'],
            name = course['Course Name'],
            credits = course['Course Credits'] or 0
        )
    object.save()

with open('courses.csv') as csvfile:
    courses = csv.DictReader(csvfile, delimiter=",")
    for course in courses:
        object = Course.objects.get(number = course['Course Number'], department = course['Course Subject'])
        object.verbose = course["\ufeffCourse ID"]
        object.save()
