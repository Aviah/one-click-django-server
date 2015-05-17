# one-click-django-server
A set of scripts to auto install a django website server on ubuntu machine



## Prep:

### Overview:
1. Buy a domain!
2. Setup a VPS (these scripts were tested on an Ubuntu 14.04 LTS Linode VPS)
3. Set the domain DNS settings to your VPS provider DNS servers (follow the instructions of your domain registrar & VPS provider docs)
4. Donwload the one-click-django-server files to your local machine (you don't need to clone a repository, just the files)
5. Edit the files (see "Text to Replace"). 
6. Copy and use your actual ssh public-key file (see "SSH Public Key")
7. Change the django SECRET_KEY string (see "Change the django SECRET_KEY")


### Text to Replace:
* Easiest way is to use a text editor that can run "replace all" on all files in a directory*

1. Replace "PUB.IP.IP.IP" with actual VPS Public IP (files: etc/hosts, etc/interfaces)
2. Replace ""GET.IP.IP.IP" with" actual VPS Getaway IP (files: etc/interfaces)
3. Replace "myusername" with your actual username (files: setup.sh)
4. Replace "www.example.com" with your actual domain (file: /etc/hosts, site_repo/settings_production.py)
5. Optional: Replace "my-django-server" with another hostname (files: /etc/hostname, etc/hosts)
6. Optional: Replace "mysite" with your actual projectname (files: setup.sh, scripts/django_projects.pth)


### SSH Public Key:

1. From the command line:

    `you@dev-machine$ cp ~/.ssh/id_rsa.pub /path/to/one-click-django-server/user/`


### Change the django SECRET_KEY:

1. From the command line (replace "foobar" with a random long string):

    `you@dev-machine$ python  /path/to/one-click-django-server/scripts/create_secret_key.py foobar`
    
2. Copy the generated key, and paste it to the SECRET_KEY entry in /path/to/one-click-django-server/site_repo/settings.py
    


## Install
** Only after prep: text was replaced, id_rsa.pub was copied, SECRET_KEY changed **

From the command line(replace PUB.IP.IP.IP with the actual VPS public IP):

1. Tar the files :
    `you@dev-machine$ tar -zcf setup.tar.gz one-click-django-server`
    
2. Backup known_hosts (in case you want to re-build the VPS and run everything again):
    `you@dev-machine$ cp ~/.ssh/known_hosts known_hosts.bak`
    
3. Upload to server: 
    `you@dev-machine$ scp setup.tar.gz root@PUB.IP.IP.IP:~/`
    
4. SSH to server:
    `you@dev-machine$ ssh root@PUB.IP.IP.IP`

5. OS Update ("root@li1234" will show the actual label/hostname your VPS provider set for the new VPS):
    `root@li1234# apt-get update`
    `root@li1234# apt-get upgrade`
        
6. Unpack:
    `root@li1234# tar -zxvf setup.tar.gz; chown -R root:root one-click-django-server`
    
7. Run setup:
    `root@li1234# cd one-click-django-server; ./setup.sh`
    
8. Reboot the server, and ssh:
```
    you@dev-machine$ ssh root@PUB.IP.IP.IP
    you@my-django-server$ echo "Hello Server"
```

9. Add the django server to your local hosts file:
    `you@dev-machine: sudo nano /etc/hosts`

10. Check: 
    `you@dev-machine: ssh my-django-server`