[![Docker Pulls](https://img.shields.io/docker/pulls/enow/kafka.svg)](https://hub.docker.com/r/enow/storm/)
[![Docker Stars](https://img.shields.io/docker/stars/enow/kafka.svg)](https://hub.docker.com/r/enow/storm/)

# docker-storm

Dockerfiles for building a storm cluster<sub>1.0.2</sub>. Referenced by [https://github.com/wurstmeister/storm-docker](https://github.com/wurstmeister/storm-docker)

The images are available directly from [https://index.docker.io](https://hub.docker.com/u/enow)

##Pre-Requisites

- install docker-compose [http://docs.docker.com/compose/install/](http://docs.docker.com/compose/install/)

##Usage

Start a cluster:

- ```docker-compose up```

Destroy a cluster:

- ```docker-compose stop```

Add more supervisors:

- ```docker-compose scale supervisor=3```

##Building

- ```rebuild.sh```

##FAQ
### How can I access Storm UI from my host?
Take a look at docker-compose.yml:

    ui:
      image: enow/storm-ui:1.0.2
	      ports:
	        - "49080:8080"

This tells Docker to expose the Docker UI container's port 8080 as port 49080 on the host<br/>

If you are running docker natively you can use localhost. If you're using docker-machine, then do:

    $ docker-machine ip
    The VM's Host only interface IP address is: 192.168.99.100

Which returns your docker VM's IP.<br/>
So, to open storm UI, type the following in your browser:

    localhost:49080

or

    192.168.99.100:49080

in my case.

### How can I deploy a topology?
Since the nimbus host and port are not default, you need to specify where the nimbus host is, and what is the nimbus port number.<br/>
Following the example above, after discovering the nimbus host IP (could be localhost, could be our docker VM ip as in the case of boot2docker), run the following command:

    storm jar target/your-topology-fat-jar.jar com.your.package.AndTopology topology-name -c nimbus.host=192.168.99.100 -c nimbus.thrift.port=49627

### How can I connect to one of the containers?
Find the forwarded ssh port for the container you wish to connect to (use `docker-compose ps`)

    $ ssh root@`boot2docker ip` -p $CONTAINER_PORT

The password is 'enow' (from: https://registry.hub.docker.com/u/enow/base/dockerfile/).
