# Edits:
# Username: Replace "myusername" with your actual username

USERNAME="myusername"

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





