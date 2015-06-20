echo "main.log"
tail /home/django/mysite/logs/main.log
echo
echo "debug.log"
tail /home/django/mysite/logs/debug.log
echo
echo "Apache error log"
tail /var/log/apache2/error.log
