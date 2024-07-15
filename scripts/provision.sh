#!/bin/bash
set -e

# Make all scripts executable
chmod +x /vagrant/scripts/*.sh

# Execute the setup scripts in order
/vagrant/scripts/setup.sh
/vagrant/scripts/project_setup.sh
/vagrant/scripts/gunicorn_service_setup.sh
/vagrant/scripts/nginx_setup.sh
/vagrant/scripts/health_check.sh
nohup /vagrant/scripts/watch_and_run.sh