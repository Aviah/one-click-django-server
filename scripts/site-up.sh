service apache2 restart
rm /etc/nginx/sites-enabled/*
ln -s /etc/nginx/sites-available/django /etc/nginx/sites-enabled/django
service nginx restart