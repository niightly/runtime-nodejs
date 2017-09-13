#!/bin/bash
set -ex

# Build script for Travis-CI.

SCRIPTDIR=$(cd $(dirname "$0") && pwd)
ROOTDIR="$SCRIPTDIR/../.."
HOMEDIR="$SCRIPTDIR/../../../"
WHISKDIR="$ROOTDIR/../openwhisk"

# Build IBM nodejs runtime
cd $ROOTDIR/8.5
docker build . -t action-nodejs-ibm-v8.5
docker tag action-nodejs-ibm-v8.5 testing/action-nodejs-ibm-v8.5


# Build OpenWhisk
cd $WHISKDIR
export OPENWHISK_HOME=$WHISKDIR
#fast options only build what we need
#TERM=dumb ./gradlew \
#:core:controller:distDocker \
#:core:invoker:distDocker \
#:core:nodejs6Action:distDocker \
#:tools:cli:distDocker \
#-PdockerImagePrefix=testing

#long version
#TERM=dumb ./gradlew distDocker -PdockerImagePrefix=testing

# Deploy OpenWhisk
#cd $WHISKDIR/ansible
#overwrite default one for now
#cp $ROOTDIR/tools/travis/ansible/group_vars/all group_vars/all
#ANSIBLE_CMD="ansible-playbook -i environments/local -e docker_image_prefix=testing"
#$ANSIBLE_CMD setup.yml
#$ANSIBLE_CMD prereq.yml
#$ANSIBLE_CMD couchdb.yml
#$ANSIBLE_CMD initdb.yml
#$ANSIBLE_CMD wipe.yml
#$ANSIBLE_CMD openwhisk.yml



