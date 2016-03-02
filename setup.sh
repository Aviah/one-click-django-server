# Edits:
# Username: Replace "myusername" with your actual username

USERNAME="myusername"
SITEPROJECTNAME="mysite"

# archive original config files
cp /etc/hostname /etc/hostname.orig
cp /etc/hosts /etc/hosts.orig
cp /etc/network/interfaces /etc/network/interfaces.orig
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig

# copy config files
cp etc/hostname /etc/
cp etc/hosts /etc/
cp etc/interfaces /etc/network/
cp etc/sshd_config /etc/ssh/

# iptables
cp etc/ip*.rules.* /etc/
cp etc/iptables.rules.firewall /etc/iptables.rules.firewall.orig
cp etc/ip6tables.rules.firewall /etc/ip6tables.rules.firewall.orig


# command line scripts
cp scripts/firewall*.sh /usr/local/bin/
cp scripts/site*.sh /usr/local/bin/
cp scripts/tail-logs.sh /usr/local/bin/

# add sudo user with ssh access
echo ">>> Adding **YOUR** user account (with sudo)"
echo "[Press ENTER to continue]"
read dummy
adduser --shell /bin/bash $USERNAME
usermod -a -G sudo $USERNAME
groupadd sshgroup
usermod -a -G sshgroup $USERNAME
mkdir /home/$USERNAME/.ssh
cp user/id_rsa.pub /home/$USERNAME/.ssh/authorized_keys
chmod 700 /home/$USERNAME/.ssh/
chmod 600 /home/$USERNAME/.ssh/authorized_keys
cp user/bash_aliases /home/$USERNAME/.bash_aliases
chown -R $USERNAME:$USERNAME /home/$USERNAME/

# Packages update
apt-get update

# django site
apt-get install python-pip
pip install Django==1.8.7
echo ">>> Adding **django** user account(another password please)"
echo "[Press ENTER to continue]"
read dummy
adduser --shell /bin/bash django
usermod -g www-data -G www-data,django,sshgroup django
mkdir /home/django/$SITEPROJECTNAME
cp scripts/manage.py /home/django/$SITEPROJECTNAME/
mkdir /home/django/$SITEPROJECTNAME/static_root
mkdir /home/django/$SITEPROJECTNAME/media_resources
mkdir /home/django/$SITEPROJECTNAME/media_uploads
cp images/favicon.ico images/powered-by-django.gif  /home/django/$SITEPROJECTNAME/media_resources/
cp images/avatar.png /home/django/$SITEPROJECTNAME/media_uploads/
mkdir /home/django/$SITEPROJECTNAME/site_config
touch /home/django/$SITEPROJECTNAME/site_config/__init__.py
cp site_repo/settings_production.py /home/django/$SITEPROJECTNAME/site_config/
cp scripts/settings_tmp.py /home/django/$SITEPROJECTNAME/site_config/
cp scripts/secrets.py /home/django/$SITEPROJECTNAME/site_config/
cp scripts/site_auth.py /home/django/$SITEPROJECTNAME/site_config/
mkdir /home/django/$SITEPROJECTNAME/db_backup
mkdir /home/django/$SITEPROJECTNAME/logs
touch /home/django/$SITEPROJECTNAME/logs/main.log
touch /home/django/$SITEPROJECTNAME/logs/debug.log
touch /home/django/$SITEPROJECTNAME/logs/debug_db.log
mkdir /home/django/$SITEPROJECTNAME/django_cache
chown -R django:www-data /home/django
chmod -R o-w /home/django
chmod -R g+r /home/django
chmod -R g+w /home/django/$SITEPROJECTNAME/logs/
cp scripts/django_projects.pth /usr/lib/python2.7/dist-packages/

# Webservers
apt-get install nginx
service nginx stop
apt-get install apache2-mpm-worker libapache2-mod-wsgi
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.orig
cp /etc/apache2/ports.conf /etc/apache2/ports.conf.orig
cp etc/nginx.conf /etc/nginx/
cp etc/apache2.conf.django /etc/apache2/apache2.conf
cp etc/apache2.conf.django /etc/apache2/
cp etc/apache2.conf.django.auth /etc/apache2/
cp etc/ports.conf /etc/apache2/
cp etc/django-site-nginx /etc/nginx/sites-available/django
ln -s /etc/nginx/sites-available/django /etc/nginx/sites-enabled/django
rm /etc/nginx/sites-enabled/default
cp etc/django-site-apache /etc/apache2/sites-available/django
ln -s /etc/apache2/sites-available/django /etc/apache2/sites-enabled/django
rm /etc/apache2/sites-enabled/000-default.conf
cp /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html.orig
cp scripts/maintenance_page.html /usr/share/nginx/html/index.html

# Database
echo; echo ">>> During the follwing MySQL installation, you will be asked to enter the MySQL root password."
echo ">>> Select a strong password, and rememeber it, you will need it soon! (Press ENTER to continue)"
echo "[Press ENTER to continue]"
read dummy
apt-get install mysql-server mysql-client
echo; echo ">>> Running mysql_secure_installation. If the root password you just entered is strong, you don't need to change it"
echo ">>> For the rest of the options, select the defaults"
echo "[Press ENTER to continue]"
read dummy
mysql_secure_installation
cp /etc/mysql/my.cnf /etc/mysql/my.cnf.orig
cp etc/my.cnf /etc/mysql/my.cnf
service mysql restart
apt-get install python-mysqldb
echo "Use MySQL root password"
mysql -uroot -p < scripts/db.sql

# Site git repository
mkdir /home/django/.ssh
cp user/id_rsa.pub /home/django/.ssh/authorized_keys
chmod 700 /home/django/.ssh/
chmod 600 /home/django/.ssh/authorized_keys
chown -R django:django /home/django/.ssh
apt-get install git
cd site_repo
git init
git add .
git commit -m 'init site repository'
cd ..
git clone --bare site_repo /home/django/site_repo.git
git clone  /home/django/site_repo.git /home/django/$SITEPROJECTNAME/site_repo/
git --git-dir=/home/django/site_repo.git remote rm origin
git --git-dir=/home/django/$SITEPROJECTNAME/site_repo/.git remote rm origin
git --git-dir=/home/django/$SITEPROJECTNAME/site_repo/.git config receive.denyCurrentBranch ignore
chown -R django:django /home/django/site_repo.git
chown -R django:www-data /home/django/$SITEPROJECTNAME/site_repo

# Init site
/home/django/mysite/manage.py migrate
echo ">>> Adding django site superuser (access to the site django administration)"
echo "[Press ENTER to continue]"
read dummy
/home/django/mysite/manage.py createsuperuser
/home/django/mysite/manage.py collectstatic
chown -R django:www-data /home/django/

service apache2 restart
service nginx restart


echo "Woohoo! Done. Reboot the machine. If everything is OK, you should be able to visit the site in your browser"
echo "Once everything works, uncomment the ip6tables firewall rules, see README"












