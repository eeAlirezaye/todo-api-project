from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('todo_api.urls')),
    path('health/', include('health_check.urls')),
]