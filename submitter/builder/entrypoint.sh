#!/bin/bash

CMD="exec bin/storm jar ./topology.jar soeun.storm.kafka.topology.StormKafkaSimpleTopology"

echo "$CMD"
eval "$CMD"
