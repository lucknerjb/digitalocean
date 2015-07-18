#!/bin/bash
set -o nounset
set -o errexit
set -o xtrace

# Ensure we're up to date
apt-get update
apt-get -y upgrade

# Install the packages we'll need
apt-get -y install build-essential
apt-get -y install emacs24
apt-get -y install fail2ban
apt-get -y install git
apt-get -y install libfreetype6
apt-get -y install libfreetype6-dev
apt-get -y install libjpeg62
apt-get -y install libjpeg-dev
apt-get -y install libpq-dev
apt-get -y install nginx
apt-get -y install postgresql
apt-get -y install postgresql-contrib
apt-get -y install python-dev
apt-get -y install python-pip
apt-get -y install unattended-upgrades
apt-get -y install uwsgi
apt-get -y install uwsgi-plugin-python
apt-get -y install zlib1g-dev

# Add the deploy user
useradd deploy
chsh deploy -s /bin/bash
mkdir /home/deploy
mkdir /home/deploy/.ssh
chmod 700 /home/deploy/.ssh

# Digital Ocean will (hopefully) have put your SSH keys in the root
# user's directory
cp ~/.ssh/authorized_keys /home/deploy/.ssh/
chmod 400 /home/deploy/.ssh/authorized_keys

# Give the deploy user permission to modify /var/www
mkdir /var/www
chown deploy:deploy /var/www -R

# Give the deploy user rights to their files
chown deploy:deploy /home/deploy -R

# Fetch and apply patches
wget https://raw.githubusercontent.com/dominicrodger/digitalocean/master/patches/nginx.conf.patch
wget https://raw.githubusercontent.com/dominicrodger/digitalocean/master/patches/sshd_config.patch
wget https://raw.githubusercontent.com/dominicrodger/digitalocean/master/patches/10periodic.patch
wget https://raw.githubusercontent.com/dominicrodger/digitalocean/master/patches/sudoers.patch
patch /etc/nginx/nginx.conf < nginx.conf.patch
patch /etc/ssh/sshd_config < sshd_config.patch
patch /etc/apt/apt.conf.d/10periodic < 10periodic.patch
patch /etc/sudoers < sudoers.patch
rm nginx.conf.path
rm sshd_config.pth
rm 10periodic.patch
rm sudoers.patch

# Restart services we've modified
service ssh restart
service nginx restart
