FROM enow/main
MAINTAINER writtic <writtic@gmail.com>

# Tells Supervisor to run interactively rather than daemonize
RUN echo [supervisord] | tee -a /etc/supervisor/supervisord.conf ; echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf

ENV STORM_VERSION 1.0.2

# Create storm group and user
ENV STORM_HOME /usr/share/apache-storm
RUN groupadd storm; useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm

# Download and Install Apache Storm from http://mirror.apache-kr.org/storm.html
RUN wget -q -O - http://mirror.apache-kr.org/storm/apache-storm-$STORM_VERSION/apache-storm-$STORM_VERSION.tar.gz | tar -xzf - -C /usr/share && \
    mv $STORM_HOME-$STORM_VERSION $STORM_HOME && \
    rm -rf apache-storm-$STORM_VERSION.tar.gz

# Create storm group and user
RUN groupadd storm; \
    useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm; \

RUN mkdir /var/log/storm ; chown -R storm:storm /var/log/storm ; \
    ln -s /var/log/storm /home/storm/log; \
    ln -s $STORM_HOME/bin/storm /usr/bin/storm
ADD conf/storm.yaml.template $STORM_HOME/conf/storm.yaml.template

# Add scripts required to run storm daemons under supervision
ADD entrypoint.sh /home/storm/entrypoint.sh
ADD supervisor/storm-daemon.conf /home/storm/storm-daemon.conf

RUN chown -R storm:storm $STORM_HOME && chmod u+x /home/storm/entrypoint.sh

# Add VOLUMEs to allow backup of config and logs
VOLUME ["/usr/share/apache-storm/conf","/var/log/storm"]

ENTRYPOINT ["/bin/bash", "/home/storm/entrypoint.sh"]
