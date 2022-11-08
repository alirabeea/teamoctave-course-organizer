from django.contrib import admin
from .models import Major, Requirement, Requirement_Course

# Register your models here.
admin.site.register(Major)
admin.site.register(Requirement)
admin.site.register(Requirement_Course)