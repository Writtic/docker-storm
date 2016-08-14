FROM enow/storm:1.0.2
MAINTAINER writtic <writtic@gmail.com>

RUN /usr/bin/config-supervisord.sh ui

EXPOSE 8080
CMD /usr/bin/start-supervisor.sh
