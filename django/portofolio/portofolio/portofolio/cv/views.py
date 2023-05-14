from django.shortcuts import render
from django.shortcuts import HttpResponse
from django.template import loader
from .import models
from cv.models import Student, Course


# def Welcome(request):
#     return HttpResponse("Welcome to our site")

def Welcome(request):
    template = loader.get_template('show.html') 
    return HttpResponse(template.render())



def list_view(request):
# dictionary for initial data with # field names as keys
    context ={}
# add the dictionary during initialization 
    context["dataset"] = Student.objects.all()
    return render(request, "list_view.html", context)

def course_view(request):
    context = {}
    context["dataset"] = Course.objects.all()
    return render(request, "course_view.html", context)