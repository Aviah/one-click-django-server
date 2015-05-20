# one-click-django-server
A set of scripts to auto install a django website server on ubuntu machine

## Intro
Tutorial with a real site
Http
Re build and try


## Prep:

### Overview:
1. Buy a domain!
2. Setup a VPS (see "Setup a VPS")
3. Donwload the one-click-django-server files to your local machine (you don't need to clone a repository, just the files)
4. Use "find & replace" to change specific bits in the files (see "Text to Replace")
5. Copy your actual ssh public-key file (see "SSH Public Key")
6. Change the django SECRET_KEY string (see "Change the django SECRET_KEY")


### Setup a VPS

1. Sign up for a VPS. For a starter django site, the cheapest VPS is OK 
2. Build the VPS OS with Ubuntu 14.04 LTS 
3. Point the domain nameserver records on your domain registrar account to the VPS provider nameservers
4. Add a DNS record for your domain & VPS 

*Note: These scripts were tested on an Ubuntu 14.04 Linode 1GB VPS*
If you sign-up with Linode:
1. Build the VPS OS: "Rebuild", select Ubuntu 14.04 LTS & root password, then click "Rebuild"
2. Set the domain nameserver on domain registrar account to ns1.linode.com, ns2.linode.com ... ns5.linode.com
3. Add DNS record: Select "DNS Manager" >> "Add a domain zone" >> enter domain, enter email, select VPS, click "Add a master zone"

If you use other VPS provider, see their docs, these steps should be fairly simple also.


### Text to Replace:
* Easiest way, and recommended, is to use a text editor that can run "replace all" on all files in a directory. *

1. Replace "PUB.IP.IP.IP" with the actual VPS Public IP (files: etc/hosts, etc/interfaces, etc/django-site-nginx)
2. Replace ""GET.IP.IP.IP" with" the actual VPS Getaway IP (files: etc/interfaces)
3. Replace "myusername" with your actual username (files: setup.sh)
4. Replace "example.com" with your actual domain (files: etc/hosts, site_repo/settings_production.py, etc/django-site-apache, etc/django-site-nginx)
5. Replace "djangomysqlpassword" with actual password. This is the password that django will use to access MySQL (files: site_repo/settings.py, scripts/django_user.sql)
6. Optional: Replace "my-django-server" with another hostname (files: etc/hostname, etc/hosts)
7. Optional: Replace "mysite" with another projectname (files: setup.sh, scripts/django_projects.pth,etc/django-site-apache)


### SSH Public Key:

1. From the command line:

    `you@dev-machine$ cp ~/.ssh/id_rsa.pub one-click-django-server/user/`

2. Backup known_hosts (in case you want to re-build the VPS and run everything again):
    `you@dev-machine$ cp ~/.ssh/known_hosts ~/.ssh/known_hosts.bak`


### Change the django SECRET_KEY:

1. From the command line (replace "foobar" with a random long string):

    `you@dev-machine$ python one-click-django-server/scripts/create_secret_key.py foobar`
    
2. Copy the generated key, and paste it to the SECRET_KEY entry in /path/to/one-click-django-server/site_repo/settings.py
    


## Install
** Only after prep: text was replaced, id_rsa.pub was copied, SECRET_KEY changed **

From the command line(replace PUB.IP.IP.IP with the actual VPS public IP):

1. Tar the files :
    `you@dev-machine$ tar -zcf setup.tar.gz one-click-django-server`
        
2. Upload to server: 
    `you@dev-machine$ scp setup.tar.gz root@PUB.IP.IP.IP:~/`
    
3. SSH to server:
    `you@dev-machine$ ssh root@PUB.IP.IP.IP`

4. OS Update ("root@li1234" will show the actual label/hostname your VPS provider set for the new VPS):
    `root@li1234# apt-get update`
        
4. Unpack:
    `root@li1234# tar -zxvf setup.tar.gz; chown -R root:root one-click-django-server`
    
6. Run setup:
    `root@li1234# cd one-click-django-server; ./setup.sh`
    
7. Reboot the server. Check the website with a browser!

8. Check SSH w/o password:
```
    you@dev-machine$ ssh PUB.IP.IP.IP
    you@my-django-server$ echo "Hello Server"
```

9. Add the django server to your local hosts file:
    `you@dev-machine: sudo nano /etc/hosts`

10. Check: 
    `you@dev-machine: ssh my-django-server`

11. OS Upgrade:
    `root@li1234# sudo apt-get update`
