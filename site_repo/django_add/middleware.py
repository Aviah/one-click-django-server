import logging
import sys
from django.http import Http404

class LogExceptions(object):
    """logs any unhandled views exceptions, ignores Http404"""

    def process_exception(self,request, exception):
        
        if isinstance(exception, Http404):
            
            return

        logging.getLogger('main').critical(exception,exc_info=sys.exc_info())
        
        return