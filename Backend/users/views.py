from django.views import View
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth.forms import UserCreationForm
from django.middleware.csrf import get_token
from django.http import JsonResponse
from .forms import UserForm
from .models import User, User_Course

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
    django_user_form = UserCreationForm()
    user_form = UserForm()

    def get(self, request, *args, **kwargs):
        return JsonResponse({"fields": ("name", "netid", "username", "password1", "password2", "email"),
                            "csrf_token": get_token(request) })

    def post(self, request, *args, **kwargs):
        django_user = UserCreationForm(request.POST)
        if django_user.is_valid():
            django_user = django_user.save(commit=False)
            data = request.POST.copy()
            data.update({'django_user': django_user.id})
            user = UserForm(data)
            if user.is_valid():
                django_user.save()
                user.save()
                return JsonResponse({"status": "Success!", "status_code": 201})
            return JsonResponse({"status": "Error!", "status_code": 401}.update(dict(user.errors)), safe=False)
        return JsonResponse({"status": "Error!", "status_code": 401}.update(dict(django_user.errors)), safe=False)

class UserCourseView(LoginRequiredMixin, View):

    def get(self, request, *args, **kwargs):
        user = User.objects.get(django_user=request.user.id)
        user_courses = User_Course.objects.filter(user=user).values()
        return JsonResponse({"courses": list(user_courses), "csrf_token": get_token(request)})

class LogoutView(LoginRequiredMixin, View):
    def get(self,request, *args, **kwargs):
        logout(request)
        return JsonResponse({"status": "Success!", "status_code": 200})