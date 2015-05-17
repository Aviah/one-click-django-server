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
cp config/hostname /etc/
cp config/hosts /etc/
cp config/interfaces /etc/network/
cp config/sshd_config /etc/ssh/


# add sudo user with ssh access
adduser --shell /bin/bash $USERNAME
usermod -a -G sudo $USERNAME
groupadd sshgroup
usermod -a -G sshgroup $USERNAME
mkdir /home/$USERNAME/.ssh
cp user/id_rsa.pub /home/$USERNAME/.ssh/authorized_keys
chmod 700 /home/$USERNAME/.ssh/
chmod 600 /home/$USERNAME/.ssh/authorized_keys
chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh/


# django site
apt-get install python-pip
pip install Django==1.8.1
useradd django -m -g www-data
mkdir /home/django/$SITEPROJECTNAME
cp -r site_repo /home/django/$SITEPROJECTNAME/
mkdir /home/django/$SITEPROJECTNAME/media_root
mkdir /home/django/$SITEPROJECTNAME/static_root
mkdir /home/django/$SITEPROJECTNAME/site_config
cp site_repo/settings_production.py /home/django/$SITEPROJECTNAME/site_config/
touch /home/django/$SITEPROJECTNAME/site_config/settings_tmp.py
mkdir /home/django/$SITEPROJECTNAME/logs
touch /home/django/$SITEPROJECTNAME/logs/main.log
touch /home/django/$SITEPROJECTNAME/logs/debug.log
touch /home/django/$SITEPROJECTNAME/logs/debug_db.log
chown -R django:www-data /home/django
chmod -R o-w /home/django
chmod -R g+r /home/django
cp scripts/django_projects.pth /usr/lib/python2.7/dist-packages/










