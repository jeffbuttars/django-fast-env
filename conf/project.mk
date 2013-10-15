
PROJECT_NAME := project_name
PROJECT_USER := project_username
PROJECT_GROUP := $(PROJECT_USER)

# Nginx settings
NGINX_USER := nginx
NGINX_DIR := /etc/nginx/conf.d/

# Postgresql settings
# PGDATA := /var/lib/pgsql/data
PGDATA := /var/lib/postgres/data

DB_NAME := $(PROJECT_NAME)
DB_USER := $(PROJECT_NAME)
DB_PASS := $(PROJECT_NAME)


# A little helper to enforce root/sudo
export BEROOT := @if [[ "$$EUID" != "0" ]]; then \
		echo "You must be root to do this, not $$EUID"; \
		exit 1; \
	fi
