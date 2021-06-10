#!/bin/bash

# deploy.sh

# Put this script on your production server and make it executable with chmod
# +x.

# Set the deploy_dir variable to the path on the production server to
# deployment directory. The script assumes the deployment directory is a git
# clone of the codebase from an upstream git repo. This script also assumes
# you are using Passenger.

deploy_dir=/srv/oivan/prd # deploy dir

# You then can run deploy.sh  remotely with ssh:
#
#     ssh user@deployserver "~/deploy.sh"


echo "=======> Setup to $deploy_dir <========"
cd $deploy_dir && bundle install --path=vendor/bundle
bash -i -c start_prd