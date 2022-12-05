from django.shortcuts import render
from django.views import View
from django.middleware.csrf import get_token
from django.http import JsonResponse

from .models import Requirement

# Create your views here.
class RequirementView(View):
    def get(self, request, *args, **kwargs):
        requirements = Requirement.objects.filter(major__name="Computer Science").values('id', 'description', 'number_courses', 'major__name')
        for req in requirements:
            req["courses"] = list(Requirement.objects.get(pk=req['id']).courses.values('course__id', 'course__verbose'))
        return JsonResponse({"requirements": list(requirements), "csrf_token": get_token(request)})