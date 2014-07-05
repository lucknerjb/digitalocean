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

# Install virtualenvwrapper
pip install virtualenvwrapper

# Add the deploy user
useradd deploy
chsh deploy -s /bin/bash
mkdir /home/deploy
mkdir /home/deploy/.ssh
chmod 700 /home/deploy/.ssh

# Digital Ocean will (hopefully) have put your SSH keys in the root's
# directory
cp ~/.ssh/authorized_keys /home/deploy/.ssh/
chmod 400 /home/deploy/.ssh/authorized_keys
chown deploy:deploy /home/deploy -R

# Give the deploy user writes to modify /var/www
mkdir /var/www
chown deploy:deploy /var/www -R


/bin/cat <<EOM >~deploy/.profile
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh
EOM

chown deploy:deploy ~deploy/.profile
