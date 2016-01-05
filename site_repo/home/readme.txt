This is a simple example of a django app.
Start a new app in the site_repo directory:
you@dev-machine:~/myprojects/mysite/site_repo/$ django-admin startapp appname
See https://docs.djangoproject.com/en/1.8/ref/django-admin/#startapp-app-label-destination

Notes:

1. A django app directory includes by default: models,views, tests, admin and migrations

2. Use the app directory only for this app code. Save helpers and code that is used for multiple apps in the site_repo/utils directory.

3. If the app uses a lot of urls, add urls.py to the app directory, and "include" this url file in the main site_repo/urls.py.
This way the main urls.py is not cluttered with specific apps urls.
See https://docs.djangoproject.com/en/1.8/topics/http/urls

4. The project loads templates from a main templates directory at site_repo/templates.
If you prefer to save the app specific templates in the app directory, django allows you to a make a "templates" subdirectory for each app.
See https://docs.djangoproject.com/en/1.8/ref/templates/api/#loader-types
Also https://docs.djangoproject.com/en/1.8/ref/django-admin/#django-admin-options---template

5. If you have many apps, it's possible to group all the apps in a main "apps" directory, so the project main directory
is not cluttered. Add an "apps" directory to site_repo, and an __init__.py file to this site_repo/apps/ directory,
Then move the apps to this directory and update INSTALLED_APPS in the main site_repo/settings.py. 
After you moved the existing apps, start new apps in this directory.

6. Migrations run on per-app basis, so you can add custom sql to your app for advanced database options that django does not support.
See https://docs.djangoproject.com/en/1.8/topics/migrations
Also https://docs.djangoproject.com/en/1.8/ref/migrations-operations/#runsql

7. Django also allows to save application specific static files in the app  "static" directory (optional). 
Collectstatic will collect these files, together with the static files in the main static directories of STATICFILES_DIRS. 
See https://docs.djangoproject.com/en/1.8/ref/contrib/staticfiles/#collectstatic

