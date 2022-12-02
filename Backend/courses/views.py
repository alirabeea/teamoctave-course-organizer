from django.shortcuts import render
from django.views import View
from django.middleware.csrf import get_token
from django.http import JsonResponse

from .models import Course

# Create your views here.
class CourseView(View):
    def get(self, request, *args, **kwargs):
        courses = Course.objects.order_by('department', 'number').values()
        return JsonResponse({"courses": list(courses), "csrf_token": get_token(request)})