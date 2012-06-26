#!/bin/bash

TOP_DIR=$(readlink -f $(dirname $BASH_SOURCE))

# Django Project name and subdir name
<<<<<<< HEAD
PROJ_NAME='django-fast-env'
=======
DJANGO_PROJ='project_rename_me'
>>>>>>> c8ec2c6a7b77ca5f291d5ad42217441217e81eed

# Gunicorn settings file
GU_SETTINGS_FILE="$TOP_DIR/$DJANGO_PROJ/gunicorn.py"


# Name of the virtualenv
VENV_OPTIONS='--no-site-packages'
VENV_NAME='venv'

function vactivate() 
{
	echo "Activating virtualenv $VENV_NAME"
	cd $TOP_DIR
	. "$VENV_NAME/bin/activate"
	cd -
} #vactivate()

function buildenv() 
{
	echo "Building and Activating virtualenv $VENV_NAME, then starting the Django project."

	oldir=$PWD
	cd $TOP_DIR

	if [[ ! -d "$VENV_NAME" ]]; then
		# Install a virutalvenv
		test -d "$VENV_NAME" || virtualenv $VENV_OPTIONS $VENV_NAME;

		# If there are requirements, install them.
		if [[ -f "./requirements.txt" ]]; then
			vactivate
			if [[ -f "$DJANGO_PROJ.pybundle"  ]]; then
				pip install "$DJANGO_PROJ.pybundle"
			fi
			pip install $(cat ./requirements.txt)
		fi
	fi

	cd $oldir 
} #buildenv()

