import logging
from django.core.cache import cache
from django.shortcuts import render
from site_repo.utils.requests import get_ip
# Create your views here.

main_logger = logging.getLogger('main')

def home_page(request):
    
    template = 'home_page.html'
    
    context = {'page_title':'It Works',
               'intro':'Hello World!'}    
    
    context['ip'] = get_ip(request)
    
    # cache
    cache.set('foo','buz')

    # logging
    main_logger.info("home page, production log")
    logging.debug("home_page, debug log")
    request.session['foo'] = 'baz' # a db interaction
    
    return render(request,template,context)
    
    
