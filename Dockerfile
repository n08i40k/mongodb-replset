FROM mongo:latest
LABEL authors="n08i40k"

# REQUIRED set of env variables
#
#    MONGO_DOMAIN: string
#    MONGO_PORT: number
#    MONGO_REPLICA_SET_NAME: string
#
#    MONGO_INITDB_DATABASE: string
#    MONGO_INITDB_ROOT_USERNAME_FILE: path-to-file
#    MONGO_INITDB_ROOT_PASSWORD_FILE: path-to-file
#
#    MONGO_PROJECTDB_USERNAME_FILE: path-to-file
#    MONGO_PROJECTDB_PASSWORD_FILE: path-to-file
#
#    MONGO_KEY_FILE_PATH: path-to-file
#    MONGO_KEY_FILE_TARGET_PATH: path-to-file

WORKDIR /app

COPY ./start.sh ./
COPY ./rs-init.sh ./

ENTRYPOINT ["bash", "/app/start.sh"]

CMD ["sh", "-c", "exec /usr/bin/mongod --bind_ip_all --port ${MONGO_PORT} --replSet \"${MONGO_REPLICA_SET_NAME}\" --auth --keyFile \"${MONGO_KEY_FILE_TARGET_PATH}\""]