from django.urls import path
from .views import CourseView

urlpatterns = [
    path('all/', CourseView.as_view(), name='courses'),
]