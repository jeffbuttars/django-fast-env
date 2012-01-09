#!/bin/bash

# source the settings and activate the virtualenv
THIS_DIR=$(readlink -f $(dirname $BASH_SOURCE))
source $THIS_DIR/../.settings.sh

cd $DJANGO_PROJ
python ./manage.py syncdb

python ./manage.py schemamigration grappelli --initial 
python ./manage.py migrate grappelli

python ./manage.py collectstatic -l
cd -

$TOP_DIR/bin/serve.sh
