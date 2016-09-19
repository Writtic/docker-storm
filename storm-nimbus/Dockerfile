FROM enow/storm
MAINTAINER writtic <writtic@gmail.com>

EXPOSE 6627
EXPOSE 3772
EXPOSE 3773

ADD start-supervisor.sh /usr/bin/start-supervisor.sh
RUN /usr/bin/config-supervisord.sh nimbus && \
    /usr/bin/config-supervisord.sh drpc && \
    chmod a+x /usr/bin/start-supervisor.sh
CMD /usr/bin/start-supervisor.sh
