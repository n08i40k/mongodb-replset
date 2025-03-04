#!/bin/bash

set -euo pipefail

chmod +x /scripts/*
ls -l /scripts/

if [ ! -f /data/db/replS.et ]; then
        echo "Can't find /data/db/replS.et! Setting up replSet..."
        touch /data/db/replS.et

        /usr/bin/mongod --bind_ip_all --replSet "$MONGO_REPLICA_SET_NAME" &
        sleep 5 && bash /scripts/rs-init.sh
fi

cp "$MONGO_KEY_FILE_PATH" "$MONGO_KEY_FILE_TARGET_PATH"
chmod 600 "$MONGO_KEY_FILE_TARGET_PATH"
echo "File exists! Skipping replSet..."
echo "KeyFile $MONGO_KEY_FILE_TARGET_PATH"

exec "$@"