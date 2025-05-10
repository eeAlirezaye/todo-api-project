from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from .models import Task
from .serializers import TaskSerializer

class TaskViewSet(viewsets.ModelViewSet):
    """
    A viewset for viewing and editing task instances.
    """
    queryset = Task.objects.all()
    serializer_class = TaskSerializer

@api_view(['GET'])
def api_overview(request):
    """
    API Overview
    """
    api_urls = {
        'List': '/tasks/',
        'Detail View': '/tasks/<id>/',
        'Create': '/tasks/',
        'Update': '/tasks/<id>/',
        'Delete': '/tasks/<id>/',
    }
    return Response(api_urls)