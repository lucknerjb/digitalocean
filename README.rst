Digital Ocean setup
===================

One of these days I'll set up enough servers that I'll take the time
to learn ansible, chef or Puppet. For now, here's some bash scripts
that set most things up as I want them.

First, fetch the setup script and run it::

    wget https://raw.githubusercontent.com/dominicrodger/digitalocean/master/initial_setup.sh
    bash initial_setup.sh

1. Make sure we've got a passwd for sudo'ing to root, and that that
   password is recorded::

    passwd deploy

2. Update ``visudo`` to use emacs::

     sudo update-alternatives --config editor

3. Modify sudoers with ``visudo``::

    root    ALL=(ALL) ALL
    deploy  ALL=(ALL) ALL
