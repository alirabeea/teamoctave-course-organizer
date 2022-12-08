import json
from urllib.parse import urlencode
from django.http import JsonResponse
from django.test import SimpleTestCase, TestCase, Client
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
# Create your tests here.
class users_view_test(SimpleTestCase):
    databases = '__all__'
    def setUp(self):
        self.user_1 = User.objects.create_user(username = 'user_1', email = 'test1@gmail.com', password = 'testpassword')   

    def test_login_get_pass(self):
        print("#1 test login_view get, expected: 401")
        response = self.client.get('/users/login/')
        self.assertEqual(response.status_code, 200)
        parseJson = json.loads(response.content.decode('utf-8'))
        self.assertEqual(parseJson['status_code'], 401)
    
    def test_login_post_existed_user(self):
        print("#2 test login_view post with existed user, expected: 201")
        existed_user = {'username': 'user_1', 'password': 'testpassword'}
        response = self.client.post('/users/login/', existed_user, content_type='application/json')
        parseJson = json.loads(response.content.decode('utf-8'))
        self.assertEqual(parseJson['status'], "Success!")
        self.assertEqual(parseJson['status_code'], 201)
        
    def test_login_post_nonexisted_user(self):
        print("#3 test login_view post with non-existed user, expected: 401")
        nonexisted_user = {'username': 'dummy', 'password':'nothing'}
        response = self.client.post('/users/login/', nonexisted_user, content_type='application/json')
        parseJson = json.loads(response.content.decode('utf-8'))
        self.assertEqual(parseJson['status_code'], 401)
        self.assertEqual(parseJson['status'], "Error!")
    
    def test_register_view_get(self):
        print("#4 test register_view post, exptected: fields")
        response = self.client.get('/users/register/')
        parseJson = json.loads(response.content.decode('utf-8'))
        self.assertEqual(parseJson['fields'], ["name","netid","username","password1","password2","email"])
    
    def test_logout_view_get(self):
        print("#5 test logout_view get, expected: 200")
        self.client.login(username = "user_1", password = "testpassword")
        response = self.client.get('/users/logout/')
        parseJson = json.loads(response.content.decode('utf-8'))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(parseJson['status_code'], 200)
        self.assertEqual(parseJson['status'], "Success!")
    
    def test_register_view_post_successful(self):
        print("#6 test register_view post, expected: 201")
        data = {
            'name':'weiqiangli',
            'netid': '123456',
            'username': 'test1',
            'email':'123456@gmail.com',
            'password1':'testpassword',
            'password2':'testpassword'
        }
        response = self.client.post('/users/register/', data, content_type='application/json')
        parseJson = json.loads(response.content.decode('utf-8'))
        self.assertEqual(parseJson['status_code'], 201)
        self.assertEqual(parseJson['status'], "Success!")

    def test_register_view_post_failure(self):
        print("#7 test register_view post with error password, expected msg: 'password_mismatch'")
        error_data = {
            'name': 'testcase',
            'netid': '12345677',
            'username': 'test2',
            'email':'123456@gmail.com',
            'password1':'testpassword',
            'password2':'differentpassword'
        }  
        response = self.client.post('/users/register/', error_data, content_type='application/json')
        error_msg = json.loads(response.content.decode('utf-8'))
        error_msg = json.loads(error_msg)
        self.assertEqual(error_msg['password2'][0]['code'], 'password_mismatch')      

    def tearDown(self):
        # Clean up after each test
        self.user_1.delete()