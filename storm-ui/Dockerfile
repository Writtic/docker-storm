FROM enow/storm
MAINTAINER writtic <writtic@gmail.com>

EXPOSE 8080

RUN /usr/bin/config-supervisord.sh ui
CMD /usr/bin/start-supervisor.sh
