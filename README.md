# One-click-django-server
###A set of scripts to auto install a complete single-server django website

[Why?](#why)    
[How?](#how)    
[The Polls Tutorial with Deployment](#the-polls-tutorial-with-deployment)   
[VPS for the Server](#vps-for-the-server)    
[What's included](#whats-included)    
[Install Prep](#install-prep)    
[Auto Install Server & Website](#auto-install-server--website)    
[What's Next](#whats-next)   

## Why?

Tutorials usually start with a local website. But it's often more useful, and more fun, to see a real working website ASAP. With a real website you see something working early, you get a better feel for the progress, and you have something to demonstrate.  
  
The following scripts allow you to (almost) automatically install a working django server. Together with the matching auto-install development environment, you get a complete development, deployment and production environment, without messing too much with configuration.

Once installed, it's easy to continue with any django tutorial, and instantly deploy to a real website. It's also a great way to learn a bit about deployment and some of django's settings quirks.

For the seasoned django developer, it's an easy way to have a new django website up and running, quickly.


## How?

Buy a domain, and sign-up for a Linux-Ubuntu VPS. 

Download the one-click-django-server files.

Edit some config files with the actual IP of your VPS, your username, domain name etc (there is a script for that). 

Upload the files to your VPS with scp, then run the setup script. After the setup script finishes, reboot the server. The website should work!
Check it in a browser.

**So with these setup scripts you should have a single server django website, development environment, and a streamlined simple deployment.** 

Following are the steps.

## The Polls Tutorial with Deployment

If you are new to django, there is also a tutorial.   
 
It's built on the official django polls tutorial, but here you learn on this real development-production environemnt. This version of the official polls tutorial includes working with git, deployment, and basic server troubleshooting.   

After running it, you will have the polls app working on a real website, at `www.yourdomain.com/polls`!

## VPS for the Server

###Server
Any Ubuntu VPS will do for the website. The script installs and configures a single-server django 1.8.7 LTS website, with MySQL, Nginx, and Apache with mod_wsgi.    
  
###VPS
Everything was tested on a Linode Ubuntu 14.04 LTS, however, any other Ubuntu VPS should work. For me Linode is great, $10 a month give you a decent VPS with full management dashboard and excellent support.      

If you decide to use Linode and wish to support the this project, please consider to sign-up with my affiliate link.
 
Support this project with my affiliate link| 
-------------------------------------------|
https://www.linode.com/?r=cc1175deb6f3ad2f2cd6285f8f82cefe1f0b3f46|

  
###Development Environment
After the auto-install of the server, use the one-click-django-dev to auto-install local website and the matching development & deployment environment.     
The auto-install of a local dev environment is available for [OSX El-Capitan](https://github.com/Aviah/one-click-django-dev-osx-el-capitan) or [Ubuntu 14.04 Trusty](https://github.com/Aviah/one-click-django-dev-ubuntu-14-04-trusty) (Ubuntu on a virtual machine will do for Windows).

*Note: For simplicity, it's a single server configuration. Everything is installed on one VPS. Also, no virtualenv, one domain per server, etc. Eventaully you will have to deal with more complex configurations, but this single server VPS can take you a long way.*



## What's Included


The one-click-django project configuration includes:

1. Basic Ubuntu Linux server configs: users, ssh, basic iptables firewall,
1. Web server: Nginx for static files & media, and as a proxy to Apache mod-wsgi
1. Database: MySQL
1. Initial project directories and files
1. Git repositories
1. Production settings, development settings
1. Static files & media
1. Logging, debug log, production log
1. Django's file based cache
1. Exceptions logging middleware
1. Optional password protect the site with Apache auth
1. Deployment with fabric, and the required fabfile
1. Maintenance page
1. A few scripts and bash aliases for common tasks
1. Favicon



## Install Prep

#### Overview:
**Step 1: Buy a domain**  
**Step 2: Sign-up for a VPS**  
**Step 3: Download & prepare the config files**  
**Step 4: Add your ssh *public* key**  
**Step 5: Save a new django secret key**  
**Step 6: Prepare server passwords**


####Isn't all this a bit fancy for a "one click"?
Good question, but actually not. In a nutshell, all you have to do is to sign-up for a VPS, buy a domain, run a local script that updates the config files with your specific ip,domain,username etc, and upload the files to the VPS. then just run the server setup script.



#### Step 1: Buy a domain

1. Buy a domain
2. Point the domain name-servers records (DNS settings) on your domain registrar account to the VPS provider name-servers


#### Step 2: Setup a VPS

1. Sign up for a VPS. For a starter django site, the cheapest Linux VPS is OK
2. Build the VPS with Ubuntu 14.04 LTS
3. Add a DNS record for your domain & VPS

  
If you are using Linode:


>These scripts were tested on a Linode VPS, which I use, so here are the steps for Linode (other VPS providers should have similar options):

>+ Sign-in to Linode, select the VPS from "Linodes"
+ Select "Rebuild", select Ubuntu 14.04 LTS, enter the root password (keep it), click "Rebuild"
+ Set the domain name server on your domain registrar account to ns1.linode.com, ns2.linode.com ... ns5.linode.com
+ In Linode, Select "DNS Manager" >> "Add a domain zone". Enter your domain, enter email, select the VPS, click "Add a master zone"
+ Select "Remote Access" to see the VPS's IP and it's gateaway IP.

> Support this project with my affiliate link| 
-------------------------------------------|
https://www.linode.com/?r=cc1175deb6f3ad2f2cd6285f8f82cefe1f0b3f46|



#### Step 3: Download & prepare the config files

1. Download the one-click-django-server files from Github. You don't need to clone a repo,
just the files.

2. Open a command line, and cd to the one-click-django-server directory

        you@dev-machine$ cd one-click-django-server
       
3. Edit find_replace.sh with your actual ip, username etc:

        you@dev-machine$ nano find_replace.sh

	
	In the editor, replace the items that start with `replace-with` with your actual data.
	
	So when you see a line like this: 
		
		sed -i "s/myusername/replace-with-your-username/g" setup.sh
			
	The edited line should look like the following:
	
		sed -i "s/myusername/john/g" setup.sh
	
	To see an example of a fully edited file, see `find_replace.example` (saved in the same directory of find_replace.sh).
	
	These are the items to edit in find_replace.sh:


	Item to replace | Replace with
----------------| ------------  
"replace-with-actual-vps-ip" | The actual VPS Public IP
"replace-with-actual-vps-getaway-ip" | The actual VPS Getaway IP
"myusername" | Your actual Linux username
"example.com" | The actual domain (don't use www, just domain.com)
"imnotsecretdjangomysqlpassword" | Actual password. This will be the password that django uses to access MySQL
Optional: "my-django-server" | The server hostname
Optional: "mysite" | The django website project name
Optional: "apacheusername" | Username for Apache auth, used when the site is password protected
Optional: "apachepasswd"  | Password for Apache auth, used when the site is password protected

	*Note: To change Optional items, you have to edit **and** uncomment the line*  
	
       
       
4. Run `find_replace.sh`: After you finished editing `find_replace.sh`, exit the editor and run the script:

        you@dev-machine$ ./find_replace.sh
       



#### Step 4: Add your ssh public key

1. From the command line (make sure you are in the `one-click-django-server` directory):

        you@dev-machine$ cp ~/.ssh/id_rsa.pub user/
2. Backup known_hosts, in case you will want to re-build the VPS and run everything again on the same VPS:

        you@dev-machine$ cp ~/.ssh/known_hosts ~/.ssh/known_hosts.bak


#### Step 5: Save a new django secret key

1. From the command line (make sure you are in the `one-click-django-server` directory):

        you@dev-machine$ python scripts/create_secret_key.py foobar
*Type a random long string instead of "foobar"*
2. Copy the generated key, and paste it to the SECRET_KEY entry in the settings.py file. To edit the file:

        you@dev-machine$ nano site_repo/settings.py
        
   In the editor, find `SECRET_KEY = "I_AM_NOT_SECRET_PLEASE_REPLACE_ME_SEE_README" `
     and replace it with `SECRET_KEY = "…"` (instead of "…" paste  the secret key you just generated).
     
#### Step 6: Prepare server passwords

During installation you will be asked to provide 4 passwords,
so it's better to prepare them beforehand and write them down.  
These are the required passwords during server instalaltion:

+ Your Linux user shell password (with sudo)
+ django Linux user shell password (no sudo)
+ MySQL root password
+ django site superuser password (for the site 'root' user)


## Auto Install Server & Website

From the command line (make sure you are in the `one-click-django-server` directory):

1. Tar the files:

        you@dev-machine$ cd ..
        you@dev-machine$ tar -zcf setup.tar.gz one-click-django-server

1. Upload to server: 

        you@dev-machine$ scp setup.tar.gz root@PUB.IP.IP.IP:~/
        
      You will have to enter the root password you provided when you built the VPS
      
      *Replace PUB.IP.IP.IP with the VPS actual IP*
      
1. SSH to server:

        you@dev-machine$ ssh root@PUB.IP.IP.IP
        
      *Replace PUB.IP.IP.IP with the VPS actual IP*

1. Unpack:

        root@vps-machine# tar -zxvf setup.tar.gz
        root@vps-machine# chown -R root:root one-click-django-server
       
      *The label "vps-machine" should show the actual label your VPS provider set for the new VPS*

1. Run setup, must run from the `one-click-django-server directory`:

        root@vps-machine# cd one-click-django-server/
        root@vps-machine# ./setup.sh

    When the script runs, you will be asked to provide 4 passwords.
         The passwords are: your Linux  user shell password (with sudo), django Linux user shell password (no sudo), MySQL root password, django superuser password (the website 'root')
    
    *Note: during installation, Linux and apt-get ask you to confirm with [Y/n]. When prompted, you should answer Yes to everything. 
    The one time you can answer "n" is when mysql secure installation asks "Change the root password". If you entered a strong MySQL root password during MySQL installation, you can answer "n" here.*
    
1. Reboot the server.

Check the website with a browser!
If eveything works, you should see something like [this website image](server_it_works.png)

Great! You have a website.



## After the site works

1. You should now have SSH to the server without a password:

        you@dev-machine$ ssh PUB.IP.IP.IP
        you@my-django-server$ echo "Hello Server"
       
   *Replace PUB.IP.IP.IP with the VPS actual IP*
  
1. Add the django server to your local hosts file:

        you@dev-machine$ sudo nano /etc/hosts

1. SSH with hostname:

        you@dev-machine$ ssh my-django-server
      
      *Replace my-django-server with the actual hostname*
      
      
1. Upgrade server:

	    you@my-django-server$ sudo apt-get upgrade


1. Uncomment the ip6tables firewall rules on the server:

	    you@my-django-server$ sudo nano /etc/network/interfaces
	    you@my-django-server$ sudo nano /usr/local/bin/firewall_up.sh
	    you@my-django-server$ sudo nano /usr/local/bin/firewall_down.sh
	    you@my-django-server$ firewall-up
       
	*The ip6tables rules sometimes have issues with the installaion, so these rules	 should be enabled after the server is ready*
	   


## What's Next?

###Install development & deployment environemnt with one-click-django-dev

Great, you have a working server with a django website!    
Now you need a local development environment:  Auto install this dev environement with one-click-django-dev.    
Similarly to the server, the one-click-django-dev scripts will auto install (almost) everything locally, and a deploy script with simple deployment reciepes.

Deploy is really easy BTW. After you install one-click-django-dev, the simplest deploy is:

	you@dev-machine: fab deploy
		

[Development on a Mac OSX 10.11 El-Capitan](https://github.com/aviah/one-click-django-dev-osx-el-capitan/)  
Install dev environment, local site & deploy scripts, on OSX 10.11 El-Capitan


[Developmetn on Ubunu 14.04](https://github.com/aviah/one-click-django-dev-ubuntu-14-04/)   
Install dev environment, local site & deploy scripts, on a clean slate Ubuntu 14.04 LTS. 

*Note:Ubuntu iss great for a virtual machine, so whatever your dev machine is, OSX or Windows, you can develop on the same OS of the server (I run Ubuntu guest on VMWare fusion).*

Once you auto install the dev local site, you will have:

1. A production website
2. A local website
3. Simple deployment scripts
4. The basic django project to further build and learn.


### Playground & Tutorial

The project's [Playground](https://github.com/aviah/one-click-django-docs/blob/master/playground.md) let's you play and experiment a bit with the django-one-click project.

If you are new to django, why not take our version to the official django polls tutorial. It implments the polls app in this real development-deployment-production environment, with git. When you finish this tutorial, the polls app will run on the real website at `www.yourdommain.com/polls`.    
Start here [Django Tutorial with Deployment](https://github.com/Aviah/one-click-django-polls-tutorial) 

### Complete project reference
The project layout, files, directories, settings, deployment, media files, logging, coding reference etc, see the [Project reference docs](https://github.com/aviah/one-click-django-docs/)

Good Luck!
	
Support this project with my affiliate link| 
-------------------------------------------|
https://www.linode.com/?r=cc1175deb6f3ad2f2cd6285f8f82cefe1f0b3f46|

