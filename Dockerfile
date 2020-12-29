# Etherpad-Lite Dockerfile using SQLite as backend.
#
# https://github.com/fuerst/etherpad-docker
# Based on work by Bernhard Fürst, bernhard.fuerst@fuerstnet.de
# that was in teurn inspired by works from John E. Arnold and Evan Hazlett.
#
# Version 1.0

# Use Docker's nodejs, which is based on ubuntu
FROM etherpad/etherpad:latest
MAINTAINER Olaf M. Kolkman, github@dacht.net

#
# EXAMPLE:
#   ETHERPAD_PLUGINS="ep_codepad ep_author_neat"
#ARG ETHERPAD_PLUGINS=



# Get Etherpad-lite's other dependencies
#RUN apt update
#RUN apt install -y sqlite3 unzip gzip curl python libssl-dev pkg-config build-essential supervisor abiword

WORKDIR /opt/

# Grab the latest Git version
#RUN curl -SLO https://github.com/ether/etherpad-lite/archive/${ETHERPAD_VERSION}.zip \
#  && unzip ${ETHERPAD_VERSION}.zip \
#  && rm ${ETHERPAD_VERSION}.zip \
#  && mv etherpad-lite-${ETHERPAD_VERSION} etherpad-lite
USER root

WORKDIR /opt/etherpad-lite

# Install node dependencies as well as the json command line tool for easy
# manipulating settings.json later.
RUN npm install sqlite3 \
 && npm install mysql \
 && npm install json5 \
 && rm settings.json


# Save original node_modules. May be needed in entrypoint.sh later.
RUN tar zcf node_modules.orig.tgz node_modules/
COPY settings-corrector.js settings-corrector.js
COPY entrypoint.sh /entrypoint.sh

# Add conf files
ADD supervisor.conf /etc/supervisor/supervisor.conf
ADD settings.json /opt/etherpad-lite/settings.json.master
 
# Allow changes to settings.conf as well as the Sqlite database being persistent.
VOLUME /opt/etherpad-lite/var

# Modules added by the Admin UI should be persistent.
VOLUME /opt/etherpad-lite/node_modules
RUN chown -R  etherpad:0 /opt/etherpad-lite/var
RUN chown -R  etherpad:0 /opt/etherpad-lite/node_modules


 
EXPOSE 9001
ENTRYPOINT ["/entrypoint.sh"]

CMD ["node","--experimental-worker","node_modules/ep_etherpad-lite/node/server.js"]

