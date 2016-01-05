"""
Django settings for site_repo project.

Generated by 'django-admin startproject' using Django 1.8.7

For more information on this file, see
https://docs.djangoproject.com/en/1.8/topics/settings/
For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.8/ref/settings/
"""
import logging
from django.core.exceptions import ImproperlyConfigured

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os

REPO_DIR = os.path.dirname(os.path.abspath(__file__))
BASE_DIR = os.path.dirname(REPO_DIR)

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'I_AM_NOT_SECRET_PLEASE_REPLACE_ME_SEE_README'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

# Change this in settings_production
ALLOWED_HOSTS = ['127.0.0.1','localhost']

# Application definition
INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'site_repo.home'
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.auth.middleware.SessionAuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'django.middleware.security.SecurityMiddleware',
)

ROOT_URLCONF = 'site_repo.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': ["%s/templates/"%REPO_DIR],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'django.template.context_processors.media',
                'site_repo.django_add.context_processors.media_res',                
            ],
        },
    },
]

WSGI_APPLICATION = 'site_repo.wsgi.application'

# Database
# https://docs.djangoproject.com/en/1.8/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'django_db',
        'USER': 'django',
        'PASSWORD':'imnotsecretdjangomysqlpassword',
        'HOST': '127.0.0.1',
        'PORT': 3306
    }
}


# Internationalization
# https://docs.djangoproject.com/en/1.8/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.8/howto/static-files/

# CSS, JavaScript
STATIC_URL = '/static/'
STATIC_ROOT = "%s/static_root/"%BASE_DIR
STATICFILES_DIRS = ["%s/static/"%REPO_DIR]
STATICFILES_STORAGE = 'django.contrib.staticfiles.storage.ManifestStaticFilesStorage'

# Site Images
MEDIA_RES_URL = '/media/'
MEDIA_RES_ROOT = "%s/media_resources/"%BASE_DIR

# Users' Uploads 
MEDIA_URL = '/uploads/'
MEDIA_ROOT = "%s/media_uploads/"%BASE_DIR


# Cache
# https://docs.djangoproject.com/en/1.8/topics/cache
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.filebased.FileBasedCache',
        'LOCATION': "%s/django_cache/"%BASE_DIR,
    }
}


# Sepcific Environment Settings (the order of imports is important)
# See https://docs.djangoproject.com/en/1.8/howto/deployment/checklist/

try:
    from site_config.settings_dev import * # development
except:
    pass # production, dev settings should not be available on production

try:
    from site_config.settings_tmp import * # tmp settings for ad-hoc changes
except:        
    pass # optional settings

try:
    from site_config.settings_production import * # production
except:
    pass # development, usually production settings are not available on development

try:
    from site_config.secrets import * # secrets are saved outside the repo
except:
    pass # optional settings



# Logging:
# https://docs.djangoproject.com/en/1.8/topics/logging

# Activate logging.debug() messages, to the log file at mysite/logs/debug.log
DEBUG_LOG = False 

# Activate django auto db logger, to the log file at mysite/logs/debug_db.log.
# Note: to activates this log, django also requires that DEBUG=True 
DEBUG_DB_LOG = False

# debug log filters (after the site_config settings imports)
class RequireDebugLogTrue(logging.Filter):
    def filter(self, record):
        return DEBUG_LOG    
class RequireDebugDBLogTrue(logging.Filter):
    def filter(self, record):
        return DEBUG_DB_LOG
    

# logging.debug('some dev msg'), will log when DEBUG_LOG=True
# logging.getLogger('main').info('some production msg'), will log when level >= info
# db interactions will auto log by django when DEBUG=True & DEBUG_DB_LOG=True
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters':{
        'standard':{
            'format':'%(asctime)s [%(levelname)s]: %(message)s'
            },
        'debug':{
            'format':'%(asctime)s %(name)s [%(levelname)s]: %(message)s'
        }          
    },    
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse',
        },
        'require_debug_true': {
            '()': 'django.utils.log.RequireDebugTrue',
        },
        'require_debug_log_true': {
            '()': RequireDebugLogTrue,
            },  
        'require_debug_db_log_true': {
            '()': RequireDebugDBLogTrue,
            },         
    },
    'handlers': {
        'default': {
            'level': 'DEBUG',
            'class': 'logging.handlers.RotatingFileHandler',
            'filters': ['require_debug_log_true'],
            'filename': "%s/logs/debug.log"%BASE_DIR,
            'maxBytes': 1024*1024*5,
            'backupCount':7,
            'formatter':'debug',
            },
        'main': {
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': "%s/logs/main.log"%BASE_DIR,
            'maxBytes': 1024*1024*5,
            'backupCount':7,
            'formatter':'standard',
            },
        'django_db': {
            'level': 'DEBUG',
            'class': 'logging.handlers.RotatingFileHandler',
            'filters': ['require_debug_db_log_true'],
            'filename': "%s/logs/debug_db.log"%BASE_DIR,
            'maxBytes': 1024*1024*5,
            'backupCount':7,
            'formatter':'standard',
            },        
        'console': {
            'level': 'INFO',
            'filters': ['require_debug_true'],
            'class': 'logging.StreamHandler',
        },
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        }
    },
    'loggers': {
        'django': {
            'handlers': ['console', 'mail_admins'],
            'propagate':True
        },
        'py.warnings': {
            'handlers': ['console'],
            'propagate':True
        },
        '': {
            'level':'DEBUG',
            'handlers': ['default'],
            'propagate':True
            },
        'main': {
            'level':'INFO',
            'handlers': ['main'],
            'propagate':True
            },
        'django.db.backends': {
            'handlers': ['django_db'],
            'propagate':False
            },         
    }
}



# one-click-django test
# Check if the repository public secret, and mysql password, was replaced
if SECRET_KEY == 'I_AM_NOT_SECRET_PLEASE_REPLACE_ME_SEE_README':
    raise ImproperlyConfigured("Change the SECRET_KEY in settings, see README")
if DATABASES['default']['PASSWORD'] == 'imnotsecret' + 'djangomysqlpassword':
    raise ImproperlyConfigured("Change the django user password to MySQL, see README")



