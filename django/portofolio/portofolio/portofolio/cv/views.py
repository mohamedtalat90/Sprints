# from django.shortcuts import render
from django.shortcuts import HttpResponse
from django.template import loader


# def Welcome(request):
#     return HttpResponse("Welcome to our site")

def Welcome(request):
    template = loader.get_template('show.html') 
    return HttpResponse(template.render())



