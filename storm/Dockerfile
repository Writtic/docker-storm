FROM enow/main
MAINTAINER writtic <writtic@gmail.com>

ENV STORM_VERSION 1.0.2
ENV STORM_HOME /usr/share/storm

# Download and Install Apache Storm from http://mirror.apache-kr.org/storm.html
RUN apt-get update -y && \
    apt-get install -y python3 && \
    wget -q -O - http://mirror.apache-kr.org/storm/apache-storm-$STORM_VERSION/apache-storm-$STORM_VERSION.tar.gz | tar -xzf - -C /usr/share && \
    mv /usr/share/apache-storm-$STORM_VERSION $STORM_HOME && \
    rm -rf apache-storm-$STORM_VERSION.tar.gz && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
# Create storm group and user
    groupadd storm; useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm; \
    chown -R storm:storm $STORM_HOME; mkdir /var/log/storm ; chown -R storm:storm /var/log/storm; \
    ln -s $STORM_HOME/bin/storm /usr/bin/storm

# Add scripts required to run storm daemons under supervision
ADD storm.yaml $STORM_HOME/conf/storm.yaml
ADD cluster.xml $STORM_HOME/logback/cluster.xml
ADD config-supervisord.sh /usr/bin/config-supervisord.sh
ADD start-supervisor.sh /usr/bin/start-supervisor.sh
RUN chmod a+x /usr/bin/config-supervisord.sh && chmod a+x /usr/bin/start-supervisor.sh

# Add VOLUMEs to allow backup of config and logs
VOLUME ["/usr/share/storm/conf", "/var/log/storm"]

# Tells Supervisor to run interactively rather than daemonize
RUN echo [supervisord] | tee -a /etc/supervisor/supervisord.conf ; echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf
