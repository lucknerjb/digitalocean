Digital Ocean setup
===================

One of these days I'll set up enough servers that I'll take the time
to learn ansible, chef or Puppet. For now, here's some bash scripts
that set most things up as I want them.

First, fetch the setup script and run it::

    wget https://raw.githubusercontent.com/dominicrodger/digitalocean/master/initial_setup.sh
    bash initial_setup.sh

Then, make sure we've set a passwd for sudo'ing to root, and ensure
that password is recorded::

    passwd deploy
