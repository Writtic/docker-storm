FROM enow/main

MAINTAINER writtic <writtic@gmail.com>

ENV STORM_VERSION 1.0.2
# Download and Install Apache Storm from http://mirror.apache-kr.org/storm.html
RUN wget -q -O - http://mirror.apache-kr.org/storm/apache-storm-$STORM_VERSION/apache-storm-$STORM_VERSION.tar.gz | tar -xzf - -C /opt
ENV STORM_HOME /opt/apache-storm-$STORM_VERSION
# Create storm group and user
RUN groupadd storm; useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm; \
    chown -R storm:storm $STORM_HOME; mkdir /var/log/storm ; chown -R storm:storm /var/log/storm
RUN ln -s $STORM_HOME/bin/storm /usr/bin/storm
# Add scripts required to run storm daemons under supervision
ADD storm.yaml $STORM_HOME/conf/storm.yaml
ADD cluster.xml $STORM_HOME/logback/cluster.xml
ADD config-supervisord.sh /usr/bin/config-supervisord.sh
ADD start-supervisor.sh /usr/bin/start-supervisor.sh
# Tells Supervisor to run interactively rather than daemonize
RUN echo [supervisord] | tee -a /etc/supervisor/supervisord.conf ; echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf
# Add VOLUMEs to allow backup of config and logs
VOLUME ["/usr/share/apache-storm/conf", "/var/log/storm"]
