# Example script that access django model in a script
import os
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "site_repo.settings")
os.environ['DJANGO_SETTINGS_MODULE'] = "site_repo.settings"

import django
django.setup()

# when the environ settings variable is defined, and django.setup()
# you can access the models and django components from a script


# Prints the username of the 1st user
from django.contrib.auth.models import User
user = User.objects.get(pk=1)
print user.username