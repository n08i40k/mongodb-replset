# MongoDB ReplicaSet Setup

This repository contains the necessary scripts and configurations to set up a MongoDB ReplicaSet using Docker. The setup
includes initializing the ReplicaSet, creating a database user, and configuring MongoDB to run with authentication and a
key file for secure communication between replica set members.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
- [Usage](#usage)
- [Scripts](#scripts)
- [Dockerfile](#dockerfile)

## Prerequisites

- Docker installed on your machine.
- A Docker registry to push the built image (optional).
- Environment variables configured for MongoDB setup.

## Configuration

The following environment variables are required for the setup:

| Variable                          | Type   | Description                                                         |
|-----------------------------------|--------|---------------------------------------------------------------------|
| `MONGO_DOMAIN`                    | string | The domain or IP address of the MongoDB instance.                   |
| `MONGO_PORT`                      | number | The port on which MongoDB will run.                                 |
| `MONGO_REPLICA_SET_NAME`          | string | The name of the MongoDB ReplicaSet.                                 |
| `MONGO_INITDB_DATABASE`           | string | The initial database to create.                                     |
| `MONGO_INITDB_ROOT_USERNAME_FILE` | secret | Path to the file containing the root username.                      |
| `MONGO_INITDB_ROOT_PASSWORD_FILE` | secret | Path to the file containing the root password.                      |
| `MONGO_PROJECTDB_USERNAME_FILE`   | secret | Path to the file containing the project database username.          |
| `MONGO_PROJECTDB_PASSWORD_FILE`   | secret | Path to the file containing the project database password.          |
| `MONGO_KEY_FILE_PATH`             | secret | Path to the key file for MongoDB authentication.                    |
| `MONGO_KEY_FILE_TARGET_PATH`      | secret | Target path where the key file will be copied inside the container. |

## Usage

1. **Clone the repository:**
   ```bash
   git clone https://git.n08i40k.ru/n08i40k/mongodb-replset.git
   cd mongodb-replset
   ```

2. **Build the Docker image:**
   ```bash
   docker build -t mongodb-replset .
   ```

3. **Run the Docker container:**
   ```bash
   docker run -d \
     --name mongodb-replset \
     -e MONGO_DOMAIN=mongodb.example.tdl \
     -e MONGO_PORT=27017 \
     -e MONGO_REPLICA_SET_NAME=rs0 \
     -e MONGO_INITDB_DATABASE=example \
     -e MONGO_INITDB_ROOT_USERNAME_FILE=/run/secrets/db_root_username \
     -e MONGO_INITDB_ROOT_PASSWORD_FILE=/run/secrets/db_root_password \
     -e MONGO_PROJECTDB_USERNAME_FILE=/run/secrets/db_username \
     -e MONGO_PROJECTDB_PASSWORD_FILE=/run/secrets/db_password \
     -e MONGO_KEY_FILE_PATH=/run/secrets/db_key_file \
     -e MONGO_KEY_FILE_TARGET_PATH=/root/db_key_file \
     mongodb-replset
   ```

## Scripts

### `rs-init.sh`

This script initializes the MongoDB ReplicaSet and creates a user with read-write permissions on the specified database.

### `start.sh`

This script is the entry point for the Docker container. It checks if the ReplicaSet is already initialized and, if not,
initializes it using `rs-init.sh`. It also copies the key file to the specified location and starts the MongoDB instance
with the appropriate configuration.

## Dockerfile

The `Dockerfile` is based on the official MongoDB image and includes the necessary scripts and configurations to set up
a MongoDB ReplicaSet. It sets the working directory, copies the scripts, and defines the entry point and command to
start MongoDB with the required options.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.