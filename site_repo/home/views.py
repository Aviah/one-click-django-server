from django.shortcuts import render

# Create your views here.

main_logger = logging.getLogger('main')

def home_page(request):
    
    template = 'home_page.html'
    context = {'page_title':'Hello!',
               'intro':'Hello World!'}
    
    # test logging
    main_logger.info("home page, production log")
    logging.debug("home_page, debug log")
    request.session['foo'] = 'baz' # a db interaction
    
    return render(request,template,context)
    
    
