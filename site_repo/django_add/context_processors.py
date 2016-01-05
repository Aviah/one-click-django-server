# custom context processors

def custom_context(request):
    """
    Custom items that are available to the templates
    """
    return {'DJANGO_VER': 'django 1.8.7 LTS'}
