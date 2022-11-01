from django.views import View
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth.forms import UserCreationForm
from django.http import JsonResponse
from .forms import UserForm

class LoginView(View):
    def get(self, request, *args, **kwargs):
        return JsonResponse({"status_code": 401})

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
        return JsonResponse({"fields": ("name", "netid", "username", "password1", "password2")})

    def post(self, request, *args, **kwargs):
        django_user = UserCreationForm(request.POST)
        user = UserForm(request.POST)
        if django_user.is_valid() and user.is_valid():
            django_user.save()
            user.save()
            return JsonResponse({"status": "Success!", "status_code": 201})
        return JsonResponse({"status": "Error!", "status_code": 401} + user.errors + django_user.errors)

class LogoutView(LoginRequiredMixin, View):
    def get(self,request, *args, **kwargs):
        logout(request)
        return JsonResponse({"status": "Success!", "status_code": 200})