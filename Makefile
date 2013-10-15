include conf/project.mk

VENV ?= .venv/bin/activate

# Create the user and group for the broker
# Add the nginx to the group
# usersetup:
#     $(BEROOT)
#     -useradd --create-home --user-group $(PROJECT_USER)

# install the nginx config
nginx: usersetup
	$(BEROOT)
	-useradd --groups $(BROKER_GROUP) $(NGINX_USER)
	install -D -b --mode 644 --owner $(NGINX_USER) conf/nginx.conf $(NGINX_DIR)/$(PROJECT_NAME)-nginx.conf
	# install -b --mode 600 --owner $(NGINX_USER) certs/server/server.crt /etc/pki/tls/certs/
	# install -b --mode 600 --owner $(NGINX_USER) certs/server/server.key /etc/pki/tls/private/
	nginx -t
	if [ -x /usr/bin/systemctl ]; then \
		systemctl restart nginx; \
		journalctl -xn; \
	else \
		/etc/init.d/nginx restart; \
	fi;

# Install the gunicorn system scripts
# gunicorn:

BROKER_GUNICORN_PID = /var/run/broker.pid
# Helper, runs gunicorn directly like it's being run by the system.
run_gunicorn:
	$(BEROOT)
	export BROKER_LOG_LEVEL=DEBUG; \
	gunicorn --log-level DEBUG --user $$USER --workers 1 -c $$PWD/conf/gunicorn_settings.py $(PROJECT_NAME).$(PROJECT_NAME).wsgi:application;

stop_guinicorn:
	$(BEROOT)
	kill $$(cat $(GUNICORN_PID))

sdist:
	python ./setup.py $@

install: nginx sdist
	$(BEROOT)
	@echo "$(PROJECT_NAME) install"
	. $(VENV); pip install dist/$(PROJECT_NAME)-1.0.0.tar.gz
