#!/bin/bash

# source the settings and activate the virtualenv
THIS_DIR=$(readlink -f $(dirname $BASH_SOURCE))
source $THIS_DIR/../.settings.sh

buildenv

echo "Start gunicorn"

cd $TOP_DIR/$PROJ_NAME

gunicorn_django --config="$GU_SETTINGS_FILE"
cd -
