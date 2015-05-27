from django.shortcuts import render

# Create your views here.

def home_page(request):
    
    template = 'home_page.html'
    context = {'page_title':'Hello!',
               'intro':'Hello World!'}
    
    return render(request,template,context)
    
    
