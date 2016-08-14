#!/bin/sh
docker run -i -t --link enow_storm_docker:nimbus -p 22 enow/storm /bin/bash
