#!/bin/bash
# storm.zookeeper.servers
STORM_ZOOKEEPER_SERVERS=
if ! [ -z "$STORM_ZOOKEEPER_SERVERS" ]; then
    # All ZooKeeper server IPs in an array
    IFS=', ' read -r -a ZOOKEEPER_SERVERS_ARRAY <<< "$STORM_ZOOKEEPER_SERVERS"
    for index in "${!ZOOKEEPER_SERVERS_ARRAY[@]}"
    do
        STORM_ZOOKEEPER_SERVERS=$STORM_ZOOKEEPER_SERVERS,"\"${ZOOKEEPER_SERVERS_ARRAY[index]}\""
    done
    STORM_ZOOKEEPER_SERVERS=[${STORM_ZOOKEEPER_SERVERS:1}]
fi
# storm.local.hostname
# For the nimbus, apply "nimbus" as default hostname
HOST=
if [[ -z "$HOST" ]] ; then
   HOST="$(hostname -i | awk '{print $1;}')" || true
fi
# supervisor.slots.ports
SUPERVISOR_SLOTS=
if [[ -z "$SUPERVISOR_SLOTS" ]] ; then
    # For a supervisor, set worker slots
    SUPERVISOR_SLOTS="[6700,6701,6702,6703]"
fi
# nimbus.seeds
NIMBUS_SEEDS=
if [[ -z "$NIMBUS_SEEDS" ]] ; then
    NIMBUS_SEEDS="[$HOST]"
fi
sed -i -e "s/%zookeeper%/$STORM_ZOOKEEPER_SERVERS/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus%/$NIMBUS_SEEDS/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%supervisor.solts%/$SUPERVISOR_SLOTS/g" $STORM_HOME/conf/storm.yaml
echo "storm.local.hostname: $HOST" >> $STORM_HOME/conf/storm.yaml
/usr/sbin/sshd && supervisord
