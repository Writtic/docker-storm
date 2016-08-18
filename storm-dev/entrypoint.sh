#!/bin/bash

# storm.zookeeper.servers
ZOOKEEPER_SERVERS_ESCAPED=
if ! [ -z "$STORM_ZOOKEEPER_SERVERS" ]; then
    # All ZooKeeper server IPs in an array
    IFS=', ' read -r -a ZOOKEEPER_SERVERS_ARRAY <<< "$STORM_ZOOKEEPER_SERVERS"
    for index in "${!ZOOKEEPER_SERVERS_ARRAY[@]}"
    do
        ZOOKEEPER_SERVERS_ESCAPED=$ZOOKEEPER_SERVERS_ESCAPED,"\\\"${ZOOKEEPER_SERVERS_ARRAY[index]}\\\""
    done
    ZOOKEEPER_SERVERS_ESCAPED=[${ZOOKEEPER_SERVERS_ESCAPED:1}]
    ZOOKEEPER_SERVERS_ESCAPED=" -c storm.zookeeper.servers=\"$ZOOKEEPER_SERVERS_ESCAPED\""
fi

# storm.local.hostname
HOST=" -c storm.local.hostname=$(hostname -i | awk '{print $1;}')"

# For the nimbus, apply "nimbus" as default hostname
for arg in "$@"
do
    if [[ $arg == "nimbus" ]] ; then
        HOST=" -c storm.local.hostname=\"nimbus\""
    fi
done

# supervisor.slots.ports
SUPERVISOR_SLOTS=
# For a supervisor, set worker slots
for arg in "$@"
do
    if [[ $arg == "supervisor" ]] ; then
        SUPERVISOR_SLOTS=" -c supervisor.slots.ports=\"[6700,6701,6702,6703]\""
    fi
done

# nimbus.seeds
# NIMBUS_SEEDS=" -c nimbus.seeds=\"[\\\"nimbus\\\"]\""
NIMBUS_SEEDS_ESCAPED=
if ! [ -z "$NIMBUS_SEEDS" ]; then
    # All nimbus seeds IPs in an array
    IFS=', ' read -r -a NIMBUS_SEEDS_ARRAY <<< "$NIMBUS_SEEDS"
    for index in "${!NIMBUS_SEEDS_ARRAY[@]}"
    do
        NIMBUS_SEEDS_ESCAPED=$NIMBUS_SEEDS_ESCAPED,"\\\"${NIMBUS_SEEDS_ARRAY[index]}\\\""
    done
    NIMBUS_SEEDS_ESCAPED=[${NIMBUS_SEEDS_ESCAPED:1}]
    NIMBUS_SEEDS_ESCAPED=" -c nimbus.seeds=\"$NIMBUS_SEEDS_ESCAPED\""
fi

# Make sure provided arguments are not overridden
for arg in "$@"
do
    if [[ $arg == *"storm.zookeeper.servers"* ]] ; then
        ZOOKEEPER_SERVERS_ESCAPED=
    fi
    if [[ $arg == *"storm.local.hostname"* ]] ; then
        HOST=
    fi
    if [[ $arg == *"supervisor.slots.ports"* ]] ; then
        SUPERVISOR_SLOTS=
    fi
    if [[ $arg == *"nimbus.seeds"* ]] ; then
        NIMBUS_SEEDS_ESCAPED=
    fi
    if [[ $arg == *"nimbus.host"* ]] ; then
        NIMBUS_SEEDS_ESCAPED=
    fi
done

CMD="exec bin/storm $@$NIMBUS_SEEDS_ESCAPED$SUPERVISOR_SLOTS$HOST$ZOOKEEPER_SERVERS_ESCAPED"

echo "$CMD"
eval "$CMD"
