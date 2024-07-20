#!/bin/bash
set -e

DIR_TO_WATCH="/vagrant/myproject"
LOG_FILE="/vagrant/logs/log.txt"

# Log File 
touch "$LOG_FILE"
chmod 664 "$LOG_FILE"

last_hash=$(find "${DIR_TO_WATCH}" -type f -exec sha256sum {} + | sha256sum | cut -d ' ' -f 1)

while true; do
    new_hash=$(find "${DIR_TO_WATCH}" -type f -exec sha256sum {} + | sha256sum | cut -d ' ' -f 1)

    if [ "${new_hash}" != "${last_hash}" ]; then
        echo "$(date): Changes detected in ${DIR_TO_WATCH}, running command." >> "$LOG_FILE"
        
        # Restart Gunicorn service
        echo "$(date): Stopping Gunicorn service" >> "$LOG_FILE"
        sudo systemctl stop myproject
        sudo systemctl daemon-reload
        sudo systemctl start myproject
        sudo systemctl enable myproject
        
        if systemctl is-active --quiet myproject; then
            echo "$(date): Gunicorn service restarted successfully" >> "$LOG_FILE"
        else
            echo "$(date): Failed to restart Gunicorn service" >> "$LOG_FILE"
        fi

        # Restart Nginx service
        echo "$(date): Restarting Nginx service" >> "$LOG_FILE"
        sudo systemctl restart nginx
        
        if systemctl is-active --quiet nginx; then
            echo "$(date): Nginx service restarted successfully" >> "$LOG_FILE"
        else
            echo "$(date): Failed to restart Nginx service" >> "$LOG_FILE"
        fi

        last_hash="${new_hash}"
    fi

    sleep 1
done