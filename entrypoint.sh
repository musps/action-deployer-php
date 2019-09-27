#!/bin/bash

set -e

if [[ -n "$ACTION_DEBUG" ]]; then
  echo "DEBUG ENABLED"
  cd $GITHUB_WORKSPACE
  SSH_PRIVATE_KEY=$(cat /data_dev/id_rsa)
fi

CMD_ARGS="$@"

# Add SSH.
eval $(ssh-agent -s)
echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
echo "$SSH_PRIVATE_KEY" | tr -d '\r' > /tmp/id_rsa
chmod 600 /tmp/id_rsa
ssh-add /tmp/id_rsa

# Start DEPLOYER.
deployer --version
deployer $CMD_ARGS
