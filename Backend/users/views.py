from django.views import View
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth.forms import UserCreationForm
from django.middleware.csrf import get_token
from django.http import JsonResponse
from .models import User, User_Course

import json

class LoginView(View):
    def get(self, request, *args, **kwargs):
        return JsonResponse({"status_code": 401, "csrf_token": get_token(request)})

    def post(self, request, *args, **kwargs):
        user = authenticate(username=request.POST["username"], password=request.POST["password"])
        if user is not None:
            login(request, user)
            return JsonResponse({"status": "Success!", "status_code": 201})
        else:
            return JsonResponse({"status": "Error!", "status_code": 401})

class RegisterView(View):
    def get(self, request, *args, **kwargs):
        return JsonResponse({"fields": ("name", "netid", "username", "password1", "password2", "email"),
                            "csrf_token": get_token(request) })

    def post(self, request, *args, **kwargs):
        data = json.loads(request.body)
        django_user = UserCreationForm(data)
        if django_user.is_valid():
            django_user = django_user.save()
            user = User(name=data['name'], netid=data['netid'], django_user=django_user)
            user.save()
            return JsonResponse({"status": "Success!", "status_code": 201})
        return JsonResponse(django_user.errors.as_json(), safe=False)

class UserCourseView(LoginRequiredMixin, View):

    def get(self, request, *args, **kwargs):
        user = User.objects.get(django_user=request.user.id)
        user_courses = User_Course.objects.filter(user=user).values()
        return JsonResponse({"courses": list(user_courses), "csrf_token": get_token(request)})

class LogoutView(LoginRequiredMixin, View):
    def get(self,request, *args, **kwargs):
        logout(request)
        return JsonResponse({"status": "Success!", "status_code": 200})