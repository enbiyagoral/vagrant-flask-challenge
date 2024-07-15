#!/bin/bash
set -e

# Find the IP address of the VM
IP_ADDR=$(hostname -I | awk '{print $2}')

# Health check
echo "Performing health check: http://$IP_ADDR:80"
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://$IP_ADDR:80)

if [ "$RESPONSE" -eq 200 ]; then
  echo "The application is running successfully."
else
  echo "The application failed. HTTP Response Code: $RESPONSE"
  exit 1
fi
