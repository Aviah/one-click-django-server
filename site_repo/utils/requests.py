# requests utils


def get_ip(request):
    
    ip = request.META['REMOTE_ADDR']
    ip = request.META.get('HTTP_X_FORWARDED_FOR',ip)
        
    return ip
        