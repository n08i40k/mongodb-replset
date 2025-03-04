#!/bin/bash

set -euo pipefail

mongosh <<EOF
rs.initiate({
    "_id": "$MONGO_REPLICA_SET_NAME",
    "version": 1,
    "members": [
        {
            "_id": 1,
            "host": "$MONGO_DOMAIN:$MONGO_PORT",
                              "priority": 1
        }
    ]
});
rs.status();
EOF

mongosh mongodb://"$MONGO_DOMAIN:$MONGO_PORT"/?replicaSet="$MONGO_REPLICA_SET_NAME" <<EOF
use $MONGO_INITDB_DATABASE
db.createUser({
  user: '$(cat "$MONGO_PROJECTDB_USERNAME_FILE")',
  pwd:  '$(cat "$MONGO_PROJECTDB_PASSWORD_FILE")',
  roles: [{
    role: 'readWrite',
    db: '$MONGO_INITDB_DATABASE'
  }]
})
db.getUsers()

db.adminCommand( { shutdown: 1 } )
EOF
