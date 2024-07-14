#!/bin/bash
set -e

# Gunicorn service setup
echo "[Unit]
Description=Gunicorn instance to serve myproject
After=network.target

[Service]
User=vagrant
Group=www-data
WorkingDirectory=/vagrant/myproject
Environment=\"PATH=/vagrant/myproject/myprojectenv/bin\"
ExecStart=/vagrant/myproject/myprojectenv/bin/gunicorn --workers 3 --bind 0.0.0.0:5000 myproject:app

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/myproject.service

# Reload systemd to pick up the new service file
sudo systemctl daemon-reload
sudo systemctl start myproject
sudo systemctl enable myproject

# Check if the service is active
if sudo systemctl is-active --quiet myproject; then
  echo "Gunicorn service is running."
else
  echo "Failed to start Gunicorn service."
  exit 1
fi
