#!/bin/bash
HOME=/home/rvm
export HOME
# Load RVM into a shell session *as a function*
if [[ -s "/home/rvm/.rvm/scripts/rvm" ]] ; then
  # First try to load from a user install
  source "/home/rvm/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  # Then try to load from a root install
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi
rvm use ruby-1.9.3
statsd -c /etc/statsd/config.yml
