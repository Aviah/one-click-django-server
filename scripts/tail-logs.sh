echo "django main.log /home/myusername/myprojects/mysite/logs/main.log"
tail /home/myusername/myprojects/mysite/logs/main.log
echo
echo "django debug.log /home/myusername/myprojects/mysite/logs/debug.log"
tail /home/myusername/myprojects/mysite/logs/debug.log
echo
echo "Apache error log /var/log/apache2/error.log"
tail /var/log/apache2/error.log
echo "Nginx error log /var/log/nginx/error.log"
tail /var/log/nginx/error.log

