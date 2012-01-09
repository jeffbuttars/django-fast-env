#!/bin/bash

TOP_DIR=$(readlink -f $(dirname $BASH_SOURCE))

# Django Project name and subdir name
DJANGO_PROJ='djangoboiler'

# Gunicorn settings
GU_LOGDIR="$TOP_DIR/logs/gunicorn"
GU_LOGFILE="$GU_LOGDIR/$DJANGO_PROJ.log"
GU_PORT=8000
GU_LOG_LEVEL='debug'
GU_NUM_WORKERS=4
GU_USER=$USER
GU_GROUP=$USER

# Name of the virtualenv
VENV_OPTIONS='--no-site-packages'
VENV_NAME='venv'

test -d $GU_LOGDIR || mkdir -p $GU_LOGDIR
touch $GU_LOGFILE

if [[ ! -d $VENV_NAME ]]; then
	# Install a virutalvenv
	test -f $VENV_NAME || virtualenv $VENV_OPTIONS $VENV_NAME
	. $VENV_NAME/bin/activate

	# If there are requirements, install them.
	if [[ -f "$TOP_DIR/requirements.txt" ]]; then
		pip install $(cat $TOP_DIR/requirements.txt)
	fi
else
	. $VENV_NAME/bin/activate
fi

