"""
URL configuration for back project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from analytics import views
from vacancies import views as vacancies_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('analytics/count_by_year', views.count_by_year),
    path('analytics/salary_by_area', views.salary_by_area),
    path('analytics/salary_by_year', views.salary_by_year),
    path('analytics/count_by_area', views.count_by_area),
    path('analytics/skills_by_year', views.skills_by_year),
    path('vacancies', vacancies_views.fetch_vacancies)
]
