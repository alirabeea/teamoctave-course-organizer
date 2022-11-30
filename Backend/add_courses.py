from courses.models import *
import csv

with open('courses.csv') as csvfile:
    courses = csv.DictReader(csvfile, delimiter=",")
    for course in courses:
        object = Course(
            number = course['Course Number'],
            department = course['Course Subject'],
            name = course['Course Name'],
            credits = course['Course Credits'] or 0
        )
        object.save()
