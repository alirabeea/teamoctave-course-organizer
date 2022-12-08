import requests

def find_course(course):
    name = course['Course ID']
    name = name.split()
    name = name[0] + '%20' + name[1]
    url = 'https://spire-api.melanson.dev/courses/' + name + '/'
    body = requests.get(url).json()
    id = body['offerings'][0]['id']
    course_offering_url = 'https://spire-api.melanson.dev/course-offerings/' + str(id) + '/'
    course_body = requests.get(course_offering_url).json()
    sections = course_body['sections']
    section = None
    for sect in sections:
        if sect['spire_id'][7:-1] == course['Section ID']:
            section = sect;
    if section is None:
        print('Error! No result.')
    else:
        section_id = section['id']
        section_url = 'https://spire-api.melanson.dev/sections/' + str(section_id) + '/'
        section_body = requests.get(section_url).json()
        availability = section_body['availability']
        print(section_body) # get section info
        print(availability) # get section availability

course = {'Course ID': 'COMPSCI 514', 'Section ID': '59832'} # search using course id and section id

find_course(course)
