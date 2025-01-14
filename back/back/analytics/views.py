from django.http import JsonResponse
from analytics.models import ProfessionCountByYear

def count_by_year(request):
    analytic_type : str = request.GET.get('type')
    if analytic_type == 'profession':
        data = ProfessionCountByYear.objects.all().values('year', 'count')
        return JsonResponse(list(data), safe=False)
    elif analytic_type == 'all':
        data = ProfessionCountByYear.objects.all().values('year', 'count')
        return JsonResponse(list(data), safe=False)
    return JsonResponse({'error': 'Invalid type'}, status=400)
        
        
