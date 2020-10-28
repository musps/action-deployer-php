#!/bin/bash

set -e

if [[ -n "$REF" && -n "$SUBSTRING" ]]; then
  REF=${REF/$SUBSTRING/}
  echo "REF: $REF"
fi

if [[ -n "$ACTION_DEBUG" ]]; then
  echo "DEBUG ENABLED"
  cd $GITHUB_WORKSPACE
  SSH_PRIVATE_KEY=$(cat /data_dev/id_rsa)
fi

if [ -z "$1" ]; then
    CMD_ARGS=""
else 
    CMD_ARGS="$@"
fi

eval $(ssh-agent -s)

echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
echo "$SSH_PRIVATE_KEY" | tr -d '\r' > /tmp/id_rsa
chmod 600 /tmp/id_rsa
ssh-add /tmp/id_rsa

composer install

deployer --version
deployer $CMD_ARGS