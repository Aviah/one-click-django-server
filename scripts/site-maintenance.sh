apache2ctl -k graceful
echo "Site will go maintenance in 1 minute"
sleep 60
rm /etc/nginx/sites-enabled/*
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
service nginx restart
