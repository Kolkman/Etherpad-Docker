# About


Run [Etherpad Lite](https://github.com/ether/etherpad-lite) inside a Docker container.

This variant of an Etherpad Docker container is characterized by:

At run time:
* Follows the _stable_ from upstream etherpad/etherpad
* Uses SQLite or MySQL as a databackend
* Persistent data, plugins and settings.
* Create administration user with configurable password.
* Support for export in DOC or PDF

# Usage

**Start an Etherpad Lite instance listening on TCP port 9001**

```
docker run -p 9001:9001 Kolkman/etherpad-docker
```

**Set password for administration user named _admin_**

```
docker run -p 9001:9001 \
  -e ETHERPAD_ADMIN_PASSWORD='my-secret-password' \
  Kolkman/etherpad-docker
```

**Make plugins, database and settings persistent**

```
docker run -p 9001:9001 \
  -v /opt/etherpad-lite/var:/opt/etherpad-lite/var \
  -v /opt/etherpad-lite/node_modules:/opt/etherpad-lite/node_modules \
  Kolkman/etherpad-docker
```


**Example Docker Compose file**

```
version: "2"

services:
  server:
    image: Kolkman/etherpad-docker:stable
    restart: always
    volumes:
      - /opt/etherpad-lite/var:/opt/etherpad-lite/var
      - /opt/etherpad-lite/node_modules:/opt/etherpad-lite/node_modules
    ports:
      - "9001:9001"
    environment:
    - ETHERPAD_ADMIN_PASSWORD=my-secret-password
```

# Documentation

See: https://github.com/ether/etherpad-lite/wiki
