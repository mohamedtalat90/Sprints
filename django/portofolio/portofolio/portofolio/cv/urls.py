from django.urls import path
from .import views

urlpatterns = [
    path('Welcome/',views.Welcome,name='Welcome'),
    path('list_view/',views.list_view,name='list_view'),
    path('course/', views.course_view, name='courses'),
]