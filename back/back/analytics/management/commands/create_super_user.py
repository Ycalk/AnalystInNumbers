import os
from django.contrib.auth import get_user_model
from django.db import IntegrityError
from django.core.management.base import BaseCommand

class Command(BaseCommand):
    def handle(self, *args, **kwargs):
        User = get_user_model()
        username = os.getenv("SUPERUSER_USERNAME")
        password = os.getenv("SUPERUSER_PASSWORD")
        User.objects.create_superuser(username=username, password=password)