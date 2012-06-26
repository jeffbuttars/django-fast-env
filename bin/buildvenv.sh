#!/bin/bash

# source the settings and activate the virtualenv
THIS_DIR=$(readlink -f $(dirname $BASH_SOURCE))
source $THIS_DIR/../.settings.sh

if [[ ! -f  "$TOP_DIR/$PROJ_NAME.pybundle" ]]; then
	$TOP_DIR/bin/bundle.sh
else
	buildenv
fi

vactivate
#. $TOP_DIR/$VENV_NAME/bin/activate

cd $PROJ_NAME

# python ./manage.py schemamigration grappelli --initial 
# python ./manage.py migrate grappelli
# python ./manage.py schemamigration core --initial 
# python ./manage.py migrate core

python ./manage.py syncdb

# python ./manage.py migrate

python ./manage.py collectstatic -l --noinput
cd -
