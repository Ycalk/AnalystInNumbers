from django.db import models

class StatByYear(models.Model):
    year = models.IntegerField()

    class Meta:
        abstract = True

class StatByArea(models.Model):
    area_name = models.CharField(max_length=100)

    class Meta:
        abstract = True

class CountByYear(StatByYear):
    count = models.IntegerField()

    class Meta:
        db_table = 'count_by_year'

class SalaryByYear(StatByYear):
    salary = models.FloatField()

    class Meta:
        db_table = 'salary_by_year'

class SalaryByCity(StatByArea):
    salary = models.FloatField()

    class Meta:
        db_table = 'salary_by_city'



