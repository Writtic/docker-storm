FROM enow/main
MAINTAINER writtic <writtic@gmail.com>

ENV STORM_VERSION 1.0.2
ENV STORM_HOME /usr/share/storm

# supervisor: worker ports
EXPOSE 6700 6701 6702 6703
# logviewer
EXPOSE 8000
# DRPC and remote deployment
EXPOSE 6627 3772 3773

# Download and Install Apache Storm
RUN alias python=python3 && \
    apt-get update -y && \
    apt-get install -y python && \
    wget -q -N http://mirror.apache-kr.org/storm/apache-storm-$STORM_VERSION/apache-storm-$STORM_VERSION.tar.gz && \
    tar -xzvf apache-storm-$STORM_VERSION.tar.gz -C /usr/share && mv /usr/share/apache-storm-$STORM_VERSION $STORM_HOME && \
    rm -rf apache-storm-$STORM_VERSION.tar.gz && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /usr/share/storm
# add startup script
ADD entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/usr/share/storm/entrypoint.sh"]
