# Persistent Etherpad-Lite Docker instance using SQLite of MySQL as
# backend.

# (c) 1920 O.M. Kolkman
# https://github.com/Kolkman/Etherpad-Docker

# Based on work by Bernhard Fürst, bernhard.fuerst@fuerstnet.de (see
# https://github.com/fuerst/etherpad-docker) that was in teurn inspired
# by works from John E. Arnold and Evan Hazlett.  Version 1.0



FROM etherpad/etherpad:1.8.13
MAINTAINER Olaf M. Kolkman, github@dacht.net


USER root



#
# EXAMPLE:
#ETHERPAD_PLUGINS="ep_codepad ep_author_neat"
#ARG ETHERPAD_PLUGINS=

WORKDIR /

# Get Etherpad-lite's other dependencies
RUN apt-get update
RUN apt-get install -y sqlite3 abiword


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

