from django.http import JsonResponse
from django.shortcuts import render
import requests

from vacancies.models import Vacancy



def fetch_vacancies(request):
    response = requests.get("https://api.hh.ru/vacancies", 
                            params={"text": "аналитик", "order_by": "publication_time"})
    result = []
    for url in [i['url'] for i in response.json()['items']][:10]:
        response = requests.get(url)
        vacancy = Vacancy.from_json(response.json())
        result.append(vacancy.to_json())
    
    return JsonResponse(result, safe=False)
    
