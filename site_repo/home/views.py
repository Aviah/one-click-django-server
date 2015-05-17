from django.shortcuts import render

# Create your views here.

def home_page(request):
    
    template = 'home_page.html'
    context = {'browser_title':'Hello!',
               'page_title':'Hello World!'}
    
    return render(request,template,context)
    
    
