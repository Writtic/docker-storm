


# docker-storm [![Docker Pulls](https://img.shields.io/docker/pulls/enow/storm.svg)](https://hub.docker.com/r/enow/storm/) [![Docker Stars](https://img.shields.io/docker/stars/enow/storm.svg)](https://hub.docker.com/r/enow/storm/)

Dockerfiles for building a storm cluster<sub>1.0.2</sub> Referenced by [https://github.com/wurstmeister/storm-docker](https://github.com/wurstmeister/storm-docker)

The images are available directly from [https://index.docker.io](https://hub.docker.com/u/enow)

## Pre-Requisites

- install [docker-compose](http://docs.docker.com/compose/install/)

## Tutorial

You can learn Apache Storm and Docker easily with https://github.com/Writtic/stormTutorial

## FAQ
### How can I access Storm UI from my host?
Take a look at docker-compose.yml:

    ui:
      image: enow/storm-ui
	      ports:
	        - "8080:8080"

This tells Docker to expose the Docker UI container's port 8080 as port 8080 on the host<br/>

If you are running docker natively you can use localhost. If you're using docker-machine, then do:

    $ docker-machine ip
    The VM's Host only interface IP address is: 192.168.99.100

Which returns your docker VM's IP.<br/>
So, to open storm UI, type the following in your browser:

    localhost:8080

or

    192.168.99.100:8080

in my case.

### How can I deploy a topology?
Since the nimbus seeds and port are not default, you need to specify where the nimbus seeds is, and what is the nimbus port number on the topology. Then you just add ```docker-compose.yml``` builder folder to your maven project and type the following:

    $ docker-compose -p storm up

### How can I connect to one of the containers?
Find the forwarded ssh port for the container you wish to connect to (use `docker-compose ps`) then edit clinet.sh

    $ client.sh
