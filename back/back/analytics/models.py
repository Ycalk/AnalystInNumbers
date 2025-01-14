from django.db import models

class StatByYear(models.Model):
    year = models.IntegerField()

    class Meta:
        abstract = True

class StatByCity(models.Model):
    city = models.CharField(max_length=100)

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

class SalaryByCity(StatByCity):
    salary = models.FloatField()

    class Meta:
        db_table = 'salary_by_city'



