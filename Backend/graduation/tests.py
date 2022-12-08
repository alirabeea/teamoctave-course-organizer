import json
from django.test import SimpleTestCase, TestCase
from django.shortcuts import render
from django.views import View
from django.middleware.csrf import get_token
from django.http import JsonResponse

from .models import Requirement
# Create your tests here.
class requirement_view_test(SimpleTestCase):
    databases = '__all__'
    
    def test_requirement_get(self):
        print("#8 requirement_view get, expected: 200")
        response = self.client.get('/graduation/requirements/')
        self.assertEqual(response.status_code, 200)
        parseJson = json.loads(response.content.decode('utf-8'))
        
    