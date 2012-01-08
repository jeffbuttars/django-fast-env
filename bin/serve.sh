#!/bin/bash

# source the settings and activate the virtualenv
THIS_DIR=$(readlink -f $(dirname $BASH_SOURCE))
source $THIS_DIR/../.settings.sh

sudo ln -vnsf $PWD/nginx/bmans.conf /etc/nginx/conf.d/
sudo systemctl restart nginx.service

echo "Start gunicorn"

cd $TOP_DIR/$DJANGO_PROJ
gunicorn_django -w $GU_NUM_WORKERS \
	-b 0.0.0.0:$GU_PORT 
	--user=$GU_USER --group=$GU_GROUP \
	--log-level=$GU_LOG_LEVEL --log-file=$GU_LOGFILE \
	$DJANGO_PROJ 2>>$GU_LOGFILE

cd -
