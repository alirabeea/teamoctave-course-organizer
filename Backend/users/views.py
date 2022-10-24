from urllib import response
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse

from .models import User 
# from django.http import HttpRequest

# Create your views here.
def sign_up(request):
    # Fetching information
    output = request.GET
    u= output['username']
    p = output['password']
    n = output['name']
    i = output['id']

    user_information = User.objects.all()
    if user_information.count() != 0 and user_information.filter(username=u).exists():
        return HttpResponse('-1')
    else:
        User.objects.create(username=u, password=p, name=n, id=i)
    return HttpResponse('success')

def log_in(request):
    output = request.GET
    username = output['username']
    password = output['password']

    user_information = User.objects.all()
    if user_information.filter(username=username, password=password).exists():
        return HttpResponse('success')
    else:
        return HttpResponse('-1')

def test(request):
    return JsonResponse({"data": "Hello World!"})