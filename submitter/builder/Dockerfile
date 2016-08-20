from enow/storm
MAINTAINER writtic <writtic@gmail.com>

ADD hellostorm-0.0.1-SNAPSHOT.jar $STORM_HOME/extlib/hellostorm-0.0.1-SNAPSHOT.jar

WORKDIR /usr/share/storm

ADD hellostorm-0.0.1-SNAPSHOT.jar topology.jar

# add startup script
ADD entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/usr/share/storm/entrypoint.sh"]
