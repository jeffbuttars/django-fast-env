#!/bin/bash

# source the settings and activate the virtualenv
THIS_DIR=$(readlink -f $(dirname $BASH_SOURCE))
source $THIS_DIR/../.settings.sh

python $DJANGO_PROJ/manage.py syncdb

python $DJANGO_PROJ/manage.py schemamigration grappelli --initial 
python $DJANGO_PROJ/manage.py migrate grappelli

python $DJANGO_PROJ/manage.py collectstatic -l

$TOP_DIR/bin/serve.sh
