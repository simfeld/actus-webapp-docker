# actus-webapp-docker

This repository contains a Docker setup for the [ACTUS demo webapp](https://github.com/actusfrf/actus-webapp). This enables you to run the application in your local development environment while keeping the dependencies (Java, Maven, Gradle, Node, NPM, MongoDB) isolated inside Docker containers and thus not conflicting your system.

## System Requirements

In order to use this setup, you need to have [Docker][docker] and [docker-compose][doco] installed on your system.
The free _Docker Community Edition (CE)_ works perfectly fine.

[docker]: https://docs.docker.com/install/
[doco]: https://docs.docker.com/compose/install/

## Preparation

First, clone this repository:

```bash
git clone https://github.com/simfeld/actus-webapp-docker.git \
  && cd actus-webapp-docker
```

This repository only contains the instructions for Docker. You also need the source code of the ACTUS demo webapp and ACTUS core.

Clone the webapp:

```bash
# in actus-webapp-docker
git clone https://github.com/actusfrf/actus-webapp.git
```

To get access to the ACTUS core repository, you need to register [here](https://www.actusfrf.org/developers). After your information is validated, you will receive an email with login credentials for the repository. Then you can clone the ACTUS core repository:

```bash
# in actus-webapp-docker
git clone https://github.com/actusfrf/actus-core.git
# you will be asked for a username and password
# -> enter the credentials received by email
```

Your directory structure should now look like this:

```
actus-webapp-docker
├── README.md
├── docker-compose.yml
├── ...
├── .gitignore
├── actus-core
│   └── ...
└── actus-webapp
    └── ...
```

## Running the project with docker-compose

To run the project using docker-compose, execute the following command:

```bash
docker-compose up -d app
```

The initial run will take some time to download and build the Docker images. The process will be faster on subsequent runs.

Once all containers are started, you can open the demo webapp in your browser trough the URL http://localhost:3000. The backend server runs at http://localhost:8080.

To stop the application, execute the following:

```bash
docker-compose down
```

## Further resources

- ACTUS FRF website: https://www.actusfrf.org/
- Docker documentation: https://docs.docker.com/
- docker-compose documentation: https://docs.docker.com/compose/
