# one-click-django-server
A set of scripts to auto install a django website server on ubuntu machine


Prep:

1. Buy a domain, and set the DNS servers 
2. Buy a VPS
3. Edit config/hosts with the VPS public IP and getway
4. Edit config/interfaces with the VPS public IP
5. Set user/id_rsa.pub

Text to Replace:

1. PUB.IP.IP.IP >> Public IP
2. GET.IP.IP.IP >> Getaway IP
3. myusername >> actual username


Install (after prep):

1. Tar the files:
    you@dev-machine$ tar -zcf setup.tar.gz one-click-django-server
    
2. Upload to server: 
    you@dev-machine$ scp setup.tar.gz root@PUB.IP.IP.IP:~/
    
3. SSH to server:
    you@dev-machine$ ssh root@PUB.IP.IP.IP
    
4. Unpack:

    root@li1234# tar -zxvf setup.tar.gz; chown -R root:root one-click-django-server
    
5. Run:

    root@li1234# cd one-click-django-server; ./setup.sh
    
6. Reboot the server, and ssh:

    you@dev-machine$ ssh root@PUB.IP.IP.IP
    you@my-django-server$ echo "Hello Server"
    
7. Edit your hosts file on dev machine, and add the django server, so you can:

    you@dev-machine: ssh my-django-server