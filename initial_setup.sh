# Ensure we're up to date
apt-get update
apt-get upgrade

# Install the packages we'll need
apt-get install build-essential emacs24 fail2ban git libjpeg libjpeg-dev libfreetype6 libfreetype6-dev libpq-dev nginx postgresql postgresql-contrib python-dev python-pip unattended-upgrades uwsgi uwsgi-plugin-python zlib1g-dev

useradd deploy
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

# Install virtualenvwrapper
pip install virtualenvwrapper

/bin/cat <<EOM >~deploy/.profile
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh
EOM

chown deploy:deploy ~deploy/.profile
