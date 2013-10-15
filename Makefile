include conf/project.mk

VENV ?= .venv/bin/activate

# Create the user and group for the broker
# Add the nginx to the group
# usersetup:
#     $(BEROOT)
#     -useradd --create-home --user-group $(PROJECT_USER)

PHONY: postgresql_conf
postgresql_conf:
	$(BEROOT)
	#sudo install --owner=postgres --group=postgres -m 0600 conf/pg_hba.conf /var/lib/pgsql/data/
	# host    $(DB_NAME)             $(DB_USER)             127.0.0.1/32            md5
	# host    $(DB_NAME)             $(DB_USER)             ::1/128                 md5
	# NOTE: the char classes are <space><tab>, using a real tab
	sed -r -i '/host[ 	]+$(DB_NAME)[ 	]+$(DB_USER)[ 	]+127\.0\.0\.1\/32[ 	]+md5[ 	]*$$/d' $(PGDATA)/pg_hba.conf
	sed -r -i '/host[ 	]+$(DB_NAME)[ 	]+$(DB_USER)[ 	]+::1\/128[ 	]+md5[ 	]*$$/d' $(PGDATA)/pg_hba.conf
	sed -r -i '/host[ 	]+test_$(DB_NAME)[ 	]+$(DB_USER)[ 	]+127\.0\.0\.1\/32[ 	]+md5[ 	]*$$/d' $(PGDATA)/pg_hba.conf
	sed -r -i '/host[ 	]+test_$(DB_NAME)[ 	]+$(DB_USER)[ 	]+::1\/128[ 	]+md5[ 	]*$$/d' $(PGDATA)/pg_hba.conf
	sed -r -i '/^[ ]*host[ 	]+all[ 	]+all[ 	]+127\.0\.0\.1\/32[ 	]+ident[ 	]*$$/s/^/#/' $(PGDATA)/pg_hba.conf
	sed -r -i '/^[ ]*host[ 	]+all[ 	]+all[ 	]+::1\/128[ 	]+ident[ 	]*$$/s/^/#/' $(PGDATA)/pg_hba.conf
	echo 'host	$(DB_NAME)	$(DB_USER)	127.0.0.1/32	md5' | sudo tee -a $(PGDATA)/pg_hba.conf
	echo 'host	$(DB_NAME)	$(DB_USER)	::1/128	        md5' | sudo tee -a $(PGDATA)/pg_hba.conf
	echo 'host	test_$(DB_NAME)	$(DB_USER)	127.0.0.1/32	md5' | sudo tee -a $(PGDATA)/pg_hba.conf
	echo 'host	test_$(DB_NAME)	$(DB_USER)	::1/128	        md5' | sudo tee -a $(PGDATA)/pg_hba.conf
	# A strange 'bug'? Create the log dir if necessary
	if [[ ! -d "$(PGDATA)/pg_log" ]]; then\
		mkdir -p $(PGDATA)/pg_log; \
		chown postgres:postgres $(PGDATA)/pg_log; \
	fi
	systemctl restart postgresql.service

$(PGDATA):
	$(BEROOT)
	-test ! -d $@/base && systemd-tmpfiles --create postgresql.conf
	mkdir -p $@
	-test ! -d $@/base && chown -c postgres:postgres $@
	-test ! -d $@/base && sudo -u postgres initdb -D '$@'
	$(MAKE) postgresql_conf
	systemctl enable postgresql.service
	systemctl restart postgresql.service

postgresql-hstore:
	$(BEROOT)
	#Enable the hstore extension and enable it on the db template
	-sudo -u postgres psql template1 -f /usr/share/postgresql/extension/hstore--1.1.sql
	-sudo -u postgres psql template1 -c "CREATE EXTENSION IF NOT EXISTS hstore;"
	# If the DB already exists, we need put hstore on it.
	-sudo -u postgres psql $(DB_NAME) -c "CREATE EXTENSION IF NOT EXISTS hstore;"

postgresql: postgresql_conf
	$(BEROOT)
	-sudo -u postgres psql -c "CREATE USER $(DB_USER) WITH PASSWORD '$(DB_PASS)'"
	-sudo -u postgres psql -c "CREATE DATABASE $(DB_NAME);"
	-sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $(DB_NAME) to $(DB_USER);"
	# -sudo -u postgres psql -c "GRANT ALL ON ALL TABLES IN SCHEMA public TO $(DB_USER);"
	# -sudo -u postgres psql -c "GRANT USAGE ON SCHEMA public TO $(DB_USER);"
	-sudo -u postgres psql -c "ALTER USER $(DB_USER) createdb;"

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

init:
	if [ -d project_name ]; then \
		mv project_name $(PROJECT_NAME); \
	fi
	if [ -d $(PROJECT_NAME)/project_name ]; then \
		mv $(PROJECT_NAME)/project_name $(PROJECT_NAME)/$(PROJECT_NAME); \
	fi
