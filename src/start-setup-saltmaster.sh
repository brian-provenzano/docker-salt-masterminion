#!/bin/bash
# set to auto accept the minions that register
sed -i 's/#auto_accept: False/auto_accept: True/g' /etc/salt/master
salt-master -l debug
# salt-minion -d
# echo "Sleeping 20 seconds to allow salt keys to generate..."
# sleep 20 #allow keygen
# echo "Begin master --> local minion key comparison..."
# /root/./keys.py #compare/approve keys
# tail -f /var/log/salt/minion -f /var/log/salt/master
