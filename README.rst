Digital Ocean setup
===================

One of these days I'll set up enough servers that I'll take the time
to learn ansible, chef or Puppet. For now, here's some bash scripts
that set most things up as I want them.

First, run everything in ``initial_setup.sh``.

After all that, follow the rest of the instructions here:
http://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers

1. Add ``/bin/bash`` to ``/etc/passwd`` for the deploy user
2. Make sure we've got a passwd for sudo'ing to root, and that that
   password is recorded.
