# replace the "replace-with..." strings with the actual data
# run this script from it's directory 

# edit tp replace
find etc -type f -print | xargs sed -i "s/PUB.IP.IP.IP/replace-with-actual-vps-ip/g"
sed -i "s/GET.IP.IP.IP/replace-with-actual-vps-getaway-ip/g" etc/interfaces
sed -i "s/myusername/replace-with-your-username/g" setup.sh
sed -i "s/imnotsecretdjangomysqlpassword/replace-with-good-password/g" site_repo/settings.py scripts/db.sql

# use yourdomain.com (or yourdomain.net, etc) without the www 
find etc site_repo -type f -print | xargs sed -i "s/example.com/replace-with-yourdomain.com/g"

# Entire site Apache password
sed -i "s/apacheusername/replace-with-another-username/g" scripts/site_auth.py
sed -i "s/apachepasswd/replace-with-another-password/g" scripts/site_auth.py


# Optional, uncomment to replace
# find etc -type f -print | xargs sed -i "s/my-django-server/replace-with-another-vps-hostname/g"
# sed -i "s/mysite/replace-with-another-project-name/g" setup.sh scripts/django_projects.pth scripts/site-reload.sh etc/apache2.conf.django etc/apache2.conf.django.auth etc/django-site-nginx
 

echo "Done. Don't forget to copy your SSH public key, and replace django SECRET_KEY. See README"