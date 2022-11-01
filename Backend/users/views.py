from django.views import View
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import JsonResponse
from .models import User

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

class LogoutView(LoginRequiredMixin, View):
    def get(self,request, *args, **kwargs):
        logout(request)
        return JsonResponse({"status": "Success!", "status_code": 200})