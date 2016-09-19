from enow/storm
MAINTAINER writtic <writtic@gmail.com>

# ADD ./target/enow-storm-1.0.jar $STORM_HOME/extlib/enow-storm-1.0.jar
WORKDIR /usr/share/storm
ADD ./submitter/enow-storm-1.0.jar topology.jar

# add startup script
ADD submitter.sh submitter.sh
RUN chmod +x submitter.sh

ENTRYPOINT ["/usr/share/storm/submitter.sh"]
