from django.db import models

# Base
class StatByYear(models.Model):
    year = models.IntegerField()

    class Meta:
        abstract = True

class StatByArea(models.Model):
    area_name = models.CharField(max_length=100)

    class Meta:
        abstract = True

# Profession models
class ProfessionCountByYear(StatByYear):
    count = models.IntegerField()

    class Meta:
        db_table = 'profession_count_by_year'

class ProfessionSalaryByYear(StatByYear):
    salary = models.FloatField()

    class Meta:
        db_table = 'profession_salary_by_year'

class ProfessionSalaryByArea(StatByArea):
    salary = models.FloatField()

    class Meta:
        db_table = 'profession_salary_by_area'

class ProfessionCountByArea(StatByArea):
    count = models.FloatField()

    class Meta:
        db_table = 'profession_count_by_area'

class ProfessionSkillsByYear(StatByYear):
    skill = models.CharField(max_length=150)
    count = models.FloatField()
    
    class Meta:
        db_table = 'profession_skills_by_year'
        
# All models
class AllCountByYear(StatByYear):
    count = models.IntegerField()

    class Meta:
        db_table = 'all_count_by_year'

class AllSalaryByYear(StatByYear):
    salary = models.FloatField()

    class Meta:
        db_table = 'all_salary_by_year'

class AllSalaryByArea(StatByArea):
    salary = models.FloatField()

    class Meta:
        db_table = 'all_salary_by_area'

class AllCountByArea(StatByArea):
    count = models.FloatField()

    class Meta:
        db_table = 'all_count_by_area'

class AllSkillsByYear(StatByYear):
    skill = models.CharField(max_length=150)
    count = models.FloatField()
    
    class Meta:
        db_table = 'all_skills_by_year'
