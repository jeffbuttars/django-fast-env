#!/bin/bash

# source the settings and activate the virtualenv
THIS_DIR=$(readlink -f $(dirname $BASH_SOURCE))
. $THIS_DIR/../.settings.sh

buildenv

cd $TOP_DIR

if [[ ! -f "$TOP_DIR/requirements.txt" ]]; then
	echo "No requirements.txt file. I'm going to create one now..."
	pip freeze > requirements.txt
fi

pip bundle $DJANGO_PROJ.pybundle $(cat $TOP_DIR/requirements.txt)

cd -
