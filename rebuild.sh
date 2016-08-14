#!/bin/bash

docker build -t="enow/storm" storm
docker build -t="enow/storm-nimbus" storm-nimbus
docker build -t="enow/storm-supervisor" storm-supervisor
docker build -t="enow/storm-ui" storm-ui
