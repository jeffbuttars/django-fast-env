#!/bin/bash

venvname='venv'
venvopts='--no-site-packages'

djangoproj='grappellibase'

# Install a virutalvenv
virtualenv $venvopts $venvname

. $venvname/bin/activate

# If there are requirements, install them.
if [[ -f requirements.txt ]]; then
	pip install $(cat ./requirements.txt)
fi

python $djangoproj/manage.py syncdb

python $djangoproj/manage.py schemamigration grappelli --initial 
python $djangoproj/manage.py migrate grappelli

python $djangoproj/manage.py collectstatic -l
python $djangoproj/manage.py runserver
