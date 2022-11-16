import json
from urllib.parse import urlencode
from django.test import SimpleTestCase, TestCase, Client
from django.contrib.auth.models import User
from django.views import View
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import authenticate, login, logout
from .forms import UserForm

# Create your tests here.
class login_view_test(SimpleTestCase):
    databases = '__all__'

    def test_login_get_pass(self):
        client = Client()
        response = client.get('/users/login/')
        self.assertEqual(response.status_code, 200)
        parseJson = json.loads(response.content.decode('utf-8'))
        self.assertEqual(parseJson['status_code'], 401)
        print("#1 test login_view get, expected: 401")
    
    def test_login_post_existed(self):
        client = Client()
        user = User.objects.create_user(username = "foo", password = "bar")
        response = client.post('/users/login/', {'username': 'foo', 'password': 'bar'})
        parseJson = json.loads(response.content.decode('utf-8'))
        self.assertEqual(parseJson['status_code'], 201)
        self.assertEqual(parseJson['status'], "Success!")
        print("#2 test login_view post with existed user, expected: 201")
    
    def test_login_post_nonexisted(self):
        client = Client()
        response = client.post('/users/login/', {'username': 'dummy', 'password':'nothing'})
        parseJson = json.loads(response.content.decode('utf-8'))
        self.assertEqual(parseJson['status_code'], 401)
        self.assertEqual(parseJson['status'], "Error!")
        print("#3 test login_view post with non-existed user, expected: 401")
    
    def test_register_view_get(self):
        client = Client()
        response = client.get('/users/register/')
        parseJson = json.loads(response.content.decode('utf-8'))
        self.assertEqual(parseJson['fields'], ["name","netid","username","password1","password2","email"])
        print("#4 test register_view post, exptected: fields")
    
    def test_logout_view_get(self):
        self.client = Client()
        self.client.login(username = "foo", password = "bar")
        response = self.client.get('/users/logout/')
        parseJson = json.loads(response.content.decode('utf-8'))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(parseJson['status_code'], 200)
        self.assertEqual(parseJson['status'], "Success!")
    """
    def test_register_view_post_failure(self):
        data = {
            'username': 'test1',
            'email':'123456@gmail.com',
            'password1':'testpassword',
        }
        client = Client()
        response = client.post('/users/register/', data)
        django_user = UserCreationForm(data)
        if django_user.is_valid:
            print("yes")
        else:
            print("no") 
        print(django_user.data)
        print("#5 test register_view post, expected: 201")
    """