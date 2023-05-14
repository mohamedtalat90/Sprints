from django.db import models

class Student(models.Model):
  f_name = models.CharField(max_length=255)
  l_name = models.CharField(max_length=255)


class Course(models.Model):
  course_name = models.CharField(max_length=255)
