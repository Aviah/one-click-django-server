# requests utils


def get_ip(request):
    
    ip = request.META['REMOTE_ADDR']
    if not ip or not ip == '127.0.0.1':
        ip = request.META.get('HTTP_X_FORWARDED_FOR',ip)
        
    return ip
        