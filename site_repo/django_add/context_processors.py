# custom context processors

from django.conf import settings

def media_res(request):
    """
    Adds media-related context variables to the context.

    """
    return {'MEDIA_RES_URL': settings.MEDIA_RES_URL}
