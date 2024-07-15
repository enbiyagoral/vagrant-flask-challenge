#!/bin/bash

DIR_TO_WATCH="/vagrant/myproject"

last_hash=$(find "${DIR_TO_WATCH}" -type f -exec sha256sum {} + | sha256sum | cut -d ' ' -f 1)

while true; do
    new_hash=$(find "${DIR_TO_WATCH}" -type f -exec sha256sum {} + | sha256sum | cut -d ' ' -f 1)

    if [ "${new_hash}" != "${last_hash}" ]; then
        echo "Changes detected in ${DIR_TO_WATCH}, running command."

        last_hash="${new_hash}"
    fi

    sleep 1
done
