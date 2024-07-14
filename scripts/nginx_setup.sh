#!/bin/bash
set -e

# Nginx setup
sudo rm /etc/nginx/sites-enabled/default
echo "server {
listen 80;
server_name localhost 127.0.0.1;

location / {
    proxy_pass http://127.0.0.1:5000;
}

}" | sudo tee /etc/nginx/sites-available/myproject

sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
sudo nginx -t
sudo systemctl restart nginx

sudo ufw delete allow 5000
sudo ufw allow 'Nginx Full'
