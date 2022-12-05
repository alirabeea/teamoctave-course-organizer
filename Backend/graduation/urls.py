from django.urls import path
from .views import RequirementView

urlpatterns = [
    path('requirements/', RequirementView.as_view(), name='requirements'),
]