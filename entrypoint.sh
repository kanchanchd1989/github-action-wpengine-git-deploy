#!/bin/sh -l
set -x
set -e

: ${WPENGINE_ENVIRONMENT_NAME?Required environment name variable not set.}
: ${WPENGINE_SSH_KEY_PRIVATE?Required secret not set.}
: ${WPENGINE_SSH_KEY_PUBLIC?Required secret not set.}

#SSH_PATH="$HOME/.ssh"
SSH_PATH="/.ssh"
WPENGINE_HOST="git.wpengine.com"
KNOWN_HOSTS_PATH="$SSH_PATH/known_hosts"
WPENGINE_SSH_KEY_PRIVATE_PATH="$SSH_PATH/wpengine_key"
WPENGINE_SSH_KEY_PUBLIC_PATH="$SSH_PATH/wpengine_key.pub"
WPENGINE_ENVIRONMENT_DEFAULT="production"
WPENGINE_ENV=${WPENGINE_ENVIRONMENT:-$WPENGINE_ENVIRONMENT_DEFAULT}
LOCAL_BRANCH_DEFAULT="master"
BRANCH=${LOCAL_BRANCH:-$LOCAL_BRANCH_DEFAULT}

mkdir "$SSH_PATH"

ssh-keyscan -t rsa "$WPENGINE_HOST" >> "$KNOWN_HOSTS_PATH"

echo "$WPENGINE_SSH_KEY_PRIVATE" > "$WPENGINE_SSH_KEY_PRIVATE_PATH"
echo "$WPENGINE_SSH_KEY_PUBLIC" > "$WPENGINE_SSH_KEY_PUBLIC_PATH"

echo "111111"

chmod 700 "$SSH_PATH"
chmod 644 "$KNOWN_HOSTS_PATH"
chmod 600 "$WPENGINE_SSH_KEY_PRIVATE_PATH"
chmod 644 "$WPENGINE_SSH_KEY_PUBLIC_PATH"

#git config core.sshCommand "ssh -i $WPENGINE_SSH_KEY_PRIVATE_PATH -o UserKnownHostsFile=$KNOWN_HOSTS_PATH"
#git remote add development git@$WPENGINE_HOST:$WPENGINE_ENV/$WPENGINE_ENVIRONMENT_NAME.git
#git push -fu $WPENGINE_ENV $BRANCH:master
git remote add development git@git.wpengine.com:production/mccdevsite.git
git push -fu development mcc-test
