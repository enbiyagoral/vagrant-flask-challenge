#!/bin/bash
set -e

# Project setup
cd /vagrant/myproject
python3 -m venv myprojectenv
source myprojectenv/bin/activate
pip install wheel

# Install packages from requirements.txt
pip install -r /vagrant/requirements.txt

# Allow port 5000 UFW
sudo ufw allow 5000

python myproject.py &

# Start the Flask application in the background
sleep 5

HEALTHCHECK_URL="http://127.0.0.1:5000"
STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}\n" $HEALTHCHECK_URL)

if [ "$STATUS_CODE" -eq 200 ]; then
  echo "Health check passed. Flask application is running."
else
  echo "Health check failed. Flask application is not running."
  exit 1
fi