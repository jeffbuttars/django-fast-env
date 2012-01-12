#!/bin/bash

# source the settings and activate the virtualenv
THIS_DIR=$(readlink -f $(dirname $BASH_SOURCE))
source $THIS_DIR/../.settings.sh

if [[ ! -f  "$TOP_DIR/$DJANGO_PROJ.pybundle" ]]; then
	$TOP_DIR/bin/bundle.sh
else
	buildenv
fi

. $TOP_DIR/$VENV_NAME/bin/activate

cd $DJANGO_PROJ
python ./manage.py syncdb

# python ./manage.py schemamigration grappelli --initial 
# python ./manage.py migrate grappelli
# 
# python ./manage.py schemamigration exampleapp --initial 
# python ./manage.py migrate exampleapp

python ./manage.py collectstatic -l
cd -
