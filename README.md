# one-click-django-server
A set of scripts to auto install a django website on a single server ubuntu machine


## Intro
Tutorial with a real site
Http
Re build and try
simple, on machine, no virtualenv etc
install everyrhing ssh, iptables etc
new  to dj - tracer bullets
experienced - just an easy way to start, up and running
rebuils, known hosts

The site is configured for the most common requirments of a django website: 
1. Web server: Nginx for media, and as a proxy to Apache2 mod-wsgi
2. Database: MySql
3. Basic iptables firewall
4. Initial project directories and files
5. Git repository
6. Django production and development settings
7. Django configuration for media & static files
8. Django logging, debug log and production log
9. Django file based cache
10. Optional password protect the site with Apache auth
11. Switching to and from a maintenance page

There are also a few useful command line aliases (site-up, site-maintenance, firewall-up etc)


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
Edit the scripts with your site specific info such as IP, domain, username etc.
Simply edit and run the find_replace.sh script: 
    
    ```you@dev-machine$ nano find_replace.sh
    you@dev-machine$ ./find_replace.sh```
    

These are the texts that you should replace (either with the find_replace script, or a text editor):

1. Replace "PUB.IP.IP.IP" with the actual VPS Public IP (files: etc/hosts, etc/interfaces, etc/django-site-nginx)
2. Replace "GET.IP.IP.IP" with" the actual VPS Getaway IP (files: etc/interfaces)
3. Replace "myusername" with your actual username (files: setup.sh)
4. Replace "example.com" with your actual domain (files: etc/hosts, site_repo/settings_production.py, etc/django-site-apache, etc/django-site-nginx)
5. Replace "imnotsecretdjangomysqlpassword" with actual password. This is the password that django will use to access MySQL (files: site_repo/settings.py, scripts/db.sql)
6. Optional: Replace "my-django-server" with another hostname (files: etc/hostname, etc/hosts)
7. Optional: Replace "mysite" with another projectname (files: setup.sh, scripts/django_projects.pth,etc/apache2.conf.django,etc/apache2.conf.django.auth,etc/site-django-nginx)
8. Optional: Replace "apacheusername", "apachepasswd" in scripts/site_auth.py



### SSH Public Key:

1. From the command line (make sure you are in the one-click-django-server directory):

    `you@dev-machine$ cp ~/.ssh/id_rsa.pub user/`

2. Backup known_hosts (in case you want to re-build the VPS and run everything again):
    `you@dev-machine$ cp ~/.ssh/known_hosts ~/.ssh/known_hosts.bak`


### Change the django SECRET_KEY:

1. From the command line (make sure you are in the one-click-django-server directory):
*type a random long string instead of "foobar"*:

    `you@dev-machine$ python scripts/create_secret_key.py foobar`
    
2. Copy the generated key, and paste it to the SECRET_KEY entry in /path/to/one-click-django-server/site_repo/settings.py
    


## Install
** Only after prep: text was replaced, id_rsa.pub was copied, SECRET_KEY changed **

* During installation you will be asked to create the following passwords (better to prepare these passwords beforehand 
):
- your linux user password (with sudo)
- django user linux user (no sudo) 
- mysql root password
- django site superuser ('root') password.


From the command line (make sure you are in the one-click-django-server directory):

1. Tar the files:
 ```you@dev-machine$ cd ..
    you@dev-machine$ tar -zcf setup.tar.gz one-click-django-server```
        
2. Upload to server (replace PUB.IP.IP.IP with the VPS actual IP): 
    `you@dev-machine$ scp setup.tar.gz root@PUB.IP.IP.IP:~/`
    
3. SSH to server:
    `you@dev-machine$ ssh root@PUB.IP.IP.IP`
        
4. Unpack ("root@li1234" will show the actual label/hostname your VPS provider sets for the new VPS) :
    `root@li1234# tar -zxvf setup.tar.gz; chown -R root:root one-click-django-server`
    
5. Run setup:
*during installations you will need to provide 3 passwords: your linux sudo user password, MySQL root password, django superuser ('root') password' *
    `root@li1234# cd one-click-django-server; ./setup.sh`
    
6. Reboot the server, then check the website with a browser!

7. Check SSH without password:
```
    you@dev-machine$ ssh PUB.IP.IP.IP
    you@my-django-server$ echo "Hello Server"
```

8. Add the django server to your local hosts file:
    `you@dev-machine$ sudo nano /etc/hosts`

9. Check: 
    `you@dev-machine$ ssh my-django-server`

10. Server packages upgrade:
    `you@my-django-server$ sudo apt-get upgrade`


## Command line aliases:

1. firewall-up: loads the firewall
2. firewall-down: clears all iptables rules, so no firewall at all. Sometimes useful for debugging
3. site-maintenance: shutsdown apache gracefuly, waits 1 minute, and moves Nginx to a one-page static maintenance html site (maintenance file is /usr/share/nginx/html/index.html)
4. site-up: restarts apache, and restart Nginx with the django site
5. site-reload: touches the wsgi file, so mod-wsgi reloads the python code. Useful if only pycode changed, and there is no need to restart Apache
6. site-auth-on: like site-up, with Apache config that protects the entire site with Apache password. The username and passowrd credentioals are in mysite/site_config/django_auth.py
7. site-auth-off: like site-up, clears the site password configs in site-auth-on
8. tail-logs: tails main.log, debug.log, Apache error.log


## Development & Deployment

1. Install a similar environment on you dev machine, where the repository is cloned from the server git repository
2. For one-click install script on an Ubuntu machine, please use the one-click-django-dev scripts. The dev environment scripts were tested on Ubuntu (there is an advantage
to develop on the same OS you deploy to), but with few adjustments should work on other Linux based (I use VMFusion Ubuntu on a mac, also works great)
3. Develop the app! 
4. To import modules in python, use from site_repo. (site_repo was configured with a pth file on the python path)
5. For javascript, css and images/media see extranl files
6. Django development server is easier to use during development. Before pushing, it's recommended to test on Nginx/Apache Locally.
7. Deployment is easy, it's a one server website. Just push the code, run collectstatic on the server if any js/css file changed, and reload the site.

See the one-click-django-dev Readme.

Note: see django docs for deployment


## Next Steps:

1. The django project is saved in the django user home directory on the server. To access the project, ssh as django:
    'you@dev-machine: ssh django@PUB.IP.IP.IP'

2. To add people, or dev machines, simply add the public ssh key to the django user authorized keys:
    '''you@dev-machine$ scp ~/.ssh/id_rsa.pub django@PUB.IP.IP.IP:~/keyname.pub
       you@dev-machine$ ssh django@PUB.IP.IP.IP
       django@my-django-server$ cat keyname.pub >> .ssh/authorized_keys'''
       
This user will allow to pull and push code, but without sudo.

3. Staging environment: can be set in a similar way, with the same scripts, just replace the IP and the staging domain.
You will need, however, to modify your git workflow between dev, staging, production
        
4. The firewall is really basic. Add some advanced and more specific rules, there are many resources on the web, books and iptables
docs.

5. If you want to save passwords, secret key etc outside the repository, use site_config directory. E.g, add a file like settings_password.py to mysite/site_config.
then add to the settings.py file:

    # to save passwords outside the repository
    # the settings_passwords.py file should exist both in dev and production environment
    from site_config import settings_password.py 


6. Mysqldump: mysqldump can be used to save and load database backups and fixtures. For example:
    Save backup:
    '''you@server: mysqldump -u django -p djangomysqlpassword --databases django_db --add-drop-database > django_db.bak.sql
    Load backup:
    you@server: mysql -u root -p mysqlrootpassword < django_db.bak.sql'''



7. Backup: Most VPS providers offer a backup (Linode does for additional fees). However, to make sure the database is in a known state,
during backup, run a mysqldump with a crontab task a few minutes before the shceduled backup.


## The project structure

The django project suggested here is built in a specific way that already arrange for logs, static files etc.
However, django is very flexible and everything could be easily changed.
This is the server directory. The local dev directory is similar, under the user home dir, and with a cloned git repo from the server

/home/django/
    |
    |- site_repo.git  (git bare repository, you push to this repo, and fetch it from the mysite/site_repo)
    |
    |- mysite (the project directory)
        |
        |- logs (site logs, not a repository))
        |   |- debug.log (django db queries, logs when DEBUG_DB_LOG = True)
        |   |- debug_db.log (your logging.debug("debug msg") log, logs when DEBUG_LOG = True)
        |   |- main.log (your logging.getLogger("main").info("production msg") log, logs everything from log level info)
        |
        |- manage.py (the django utility for the project)
        |
        |- media_resources (pre-prepared site media directory, not a repository. e.g. logo, icons, etc)
        |
        |- media_uploads (media directory, not a repository, for user uploaded resources, e.g. avatars)
        |
        |- site_config (optional settings directory on the python path, but not in a repository)
        |   |
        |   |- settings_production.py (settings.py will try to import this file, make sure it exists in production)
        |   |- settings_tmp.py (settings.py will try to import this file, useful for ad-hoc settings during dev)
        |   |- site_auth.py (credentials for password-protected site via Apache auth, if used)
        |
        |- site_repo (this is the actual code repository for your django webapp project)
        |   |
        |   |- settings.py
        |   |- urls.py 
        |   |- wsgi.py 
        |   etc...
        |
        |- static_root (static js & css files, created from the repository with manage.py collectstatic, this dir is not a repository)
 
 
## Settings

...
          
  
## Django administration

..., change the admin url...

  
  
## Extrnal files: JS, CSS, images  

Out of the box, django seperates extrnal resources into two categories: site resources, and user uploads. Each is served from it's own url and root directory.
However, it's often handy to have three categories, as follows:
1. js & css scripts: These are the files that often change during development, and thus served after manage.py collectstatic. During development, they are served from the repository.
2. Other, non js or css, pre-prepared and optimised assets: e.g. logo, icons etc. Always served from a different directory, outside the repository
3. User uploads: e.g. avatars, another directory

For external files expire date and browser cache see "Webservers"
        
### Script files (JS,CSS):

1. During development, set DEBUG=True, and work on the static files in the repository, at my_site/site_repo/static. Changes you make
to the files are reflected in site.
2. Files will be available in 127.0.0.1:8000 in django dev server (manage.py runserver), when DEBUG=True.
3. Refernces to the js,css files in the templates should use the "static" template tag (see base.html)
4. In production, DEBUG=False, and files are served directly by Nginx from the STATIC_ROOT directory (mysite/static_root) with Nginx's location alias.
5. To see changes made to static files when DEBUG=False, you must run from the mysite directory:
    '''you@dev-or-production-machine: python manage.py collectstatic'''
6. For testing, sometimes debugging, it's handy to use Nginx/Apache with DEBUG=True. In this case, files are served from the repository static directory by django (my_site/site_repo/static).

Summary: Edit and work on static files when DEBUG=True, once everything works, run collectstatic and test with Nginx/Apache with DEBUG=False, then deploy.

Note: django development server will not serve static files when DEBUG=False
Note: django also supports serving static files from an application's  directory, see django docs
Note: django will pick any other static resource using the "static" url or directory. However, for non js, css, it helps to use different URL and directory, as follows.


### Non js/css pre-prepared resources:

1. Files are served from mysite/media_resources/ directory, both for runserver , or via Nginx.
2. Copy the logo, icons (or any other non js,css resource) files to this directory. On production, to /home/django/mysite/media_resources, using the django user permissions
example: ```you@dev-machine: scp logo.png django@PUB.IP.IP.IP:~/mysite/media_resources/```
3. Files will be available in 127.0.0.1:8000 in django dev server when DEBUG=True
4. Refernces to these files in templates should use {{ MEDIA_RES_URL }} (see base_home.html)
5. Favicon is also served from this directory. The file is media_resources/favicon.ico (see base.html )
6. In production, or production testing, the files are served by Nginx directly from the same directory. 
7. Do not replace files with other files with same name, since browsers may still show the older files from cache


### Uploads:
1. Files are served from media_uploads/ directory, both for runserver , or via Nginx
2. Uploads are configured with MEDIA_URL and MEDIA_ROOT, django's settings for uploaded files, see django docs
3. For complete info about uploads see django docs. This project config respects django default to use MEDIA_URL and MEDIA_ROOT for uploads.


## Scripts and media files deloyment:

1. Commit and push the site_repo code
2. Run collectstatic on the server
3. scp images, icons etc to mysite/media_resources/
4. Reload site

Note: This deployment assumes one webserver, see django docs

## Templates:

Templates are saved in the site_repo/templates directory.

Note: django also supports serving templates from an application's  directory, see django docs


## Logging:

1. Logs are saved to the project logs/ directory
2. For dev, set DEBUG_LOG=True, and use logging.debug('debug msg'), which logs to mysite/logs/debug.log, when DEBUG_LOG=True
3. For production, use logging.getLogger('main').info('production msg'), which logs to mysite/logs/main.log when log level >= info.
4. The debug log is configured as root log, so it can be used without getLogger, only logging.debug. 
5. During development, it's easy to work only with debug.log, which also gets both debug and the 'main' logger,
so everything is in one place. The debug logs said which message was logged to debug (root), and which was propagated from main.
6. On production, just set DEBUG_LOG=False, unless debug logging is required to debug something on the server.
7. Django can automatically log all db transactions. This feature is really handy during development, but a preformance issue on production.
To use this logger set DEBUG_DB_LOG=True. If also DEBUG=True, the db activity is logged to mysite/logs/debug_db.log.

Note: django provides many other loggers and options, see docs.


## Cache:

1. A simple basic file-based cache (the directory is mysite/django_cache)
2. To use the cache: from django.core.cache import cache, and then cache.set, cache.get etc (see home/views.py)

Note: django provides many other caching options, multiple caches, etc. see docs.


## Web servers:

1. Runserver: Develop and test with django development server, on 127.0.0.1:8000. When DEBUG=True, everything is served with this server.
2. Nginx,Apache: Nginx passes the python code to the Apache (with mod_wsgi) proxy, and serves the static files, media and uploads directly
directly.
3. In Nginx, the static,media resoruces and uploads dirs are configured to 180d expiry. This will affect script files (css,jss), since any change is reflected with a new
name by collectstatic. Images, however, in media resources and uploads, will be served from browser cache for this period. Changing them requires to a new file with a new name
(so the browser do not find a cached version)
4. During initial development, when the images change, just clear the browser cache, use a new "incognito" window, or change the 180d config in /etc/nginx/sites-enabled/django