import csv
from django.core.management.base import BaseCommand
from analytics.models import ProfessionCountByYear, ProfessionSalaryByArea, ProfessionSalaryByYear, ProfessionCountByArea, ProfessionSkillsByYear
from analytics.models import AllCountByYear, AllSalaryByArea, AllSalaryByYear, AllCountByArea, AllSkillsByYear
from django.db import models

class Command(BaseCommand):
    help = 'Load data from a CSV file into chosen model'
    
    def add_arguments(self, parser):
        parser.add_argument('csv_file', type=str)
        parser.add_argument('model', type=str)

    def __get_model(self, model_name) -> models.Model:
        models = {
            'ProfessionCountByYear': ProfessionCountByYear,
            'ProfessionSalaryByArea': ProfessionSalaryByArea,
            'ProfessionSalaryByYear': ProfessionSalaryByYear,
            'ProfessionCountByArea': ProfessionCountByArea,
            'ProfessionSkillsByYear': ProfessionSkillsByYear,
            'AllCountByYear' : AllCountByYear,
            'AllSalaryByArea': AllSalaryByArea,
            'AllSalaryByYear': AllSalaryByYear,
            'AllCountByArea': AllCountByArea,
            'AllSkillsByYear': AllSkillsByYear
        }
        return models[model_name]
    
    def handle(self, *args, **kwargs):
        csv_file = kwargs['csv_file']
        model = self.__get_model(kwargs['model'])
        with open(csv_file, newline='', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            model_fields = [field.name for field in model._meta.get_fields()]
            for row in reader:
                filtered_data = {key: value for key, value in row.items() if key in model_fields}
                model.objects.create(**filtered_data)
        self.stdout.write(self.style.SUCCESS(f'Data loaded successfully into {model.__name__}'))
