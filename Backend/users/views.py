from django.views import View
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth.forms import UserCreationForm
from django.middleware.csrf import get_token
from django.http import JsonResponse
from .models import User, User_Course

from graduation.models import Requirement
import json

class LoginView(View):
    def get(self, request, *args, **kwargs):
        return JsonResponse({"status_code": 401, "csrf_token": get_token(request)})

    def post(self, request, *args, **kwargs):
        data = json.loads(request.body)
        user = authenticate(username=data["username"], password=data["password"])
        if user is not None:
            login(request, user)
            return JsonResponse({"status": "Success!", "status_code": 201})
        else:
            return JsonResponse({"status": "Error!", "status_code": 401})

class RegisterView(View):
    def get(self, request, *args, **kwargs):
        return JsonResponse({"fields": ["name", "netid", "username", "password1", "password2", "email"],
                            "csrf_token": get_token(request) })

    def post(self, request, *args, **kwargs):
        data = json.loads(request.body)
        django_user = UserCreationForm(data)
        print("right before is valid")
        if django_user.is_valid():
            print("inside is valid")
            django_user = django_user.save()
            user = User(name=data['name'], netid=data['netid'], django_user=django_user)
            user.save()
            return JsonResponse({"status": "Success!", "status_code": 201})
        return JsonResponse(django_user.errors.as_json(), safe=False)

class UserCourseView(View):

    def get(self, request, *args, **kwargs):
        return JsonResponse({"csrf_token": get_token(request)})

    # POST Data Format: {'courses': [1, 2, 3, 7, 16], 'username': 'blah blah}, where the numbers represent list of course ids 
    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body)
            user = User.objects.get(django_user__username=data["username"])
            requirements = data['courses']
            for requirement in requirements:
                req = Requirement.objects.get(pk=int(requirement))
                courses = req.courses
                for course in courses:
                    object = User_Course(user=user, course=course.course)
                    object.save()
            return JsonResponse({"status": "Success!", "status_code": 201})
        except:
            return JsonResponse({"status": "Error!", "status_code": 401})


class LogoutView(LoginRequiredMixin, View):
    def get(self,request, *args, **kwargs):
        logout(request)
        return JsonResponse({"status": "Success!", "status_code": 200})