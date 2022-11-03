from django.urls import path
from .views import LoginView, LogoutView, RegisterView, UserCourseView

urlpatterns = [
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('register/', RegisterView.as_view(), name='register'),
    path("courses/", UserCourseView.as_view(), name="user_courses")
]