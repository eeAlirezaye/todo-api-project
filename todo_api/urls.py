from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()
router.register(r'tasks', views.TaskViewSet)

urlpatterns = [
    path('', views.api_overview, name='api-overview'),
    path('', include(router.urls)),
]