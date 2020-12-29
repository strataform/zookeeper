#!/usr/bin/env bash

set -e

HOSTNAME_ID=$(hostname | grep -o -E '[0-9]+')
MY_ID=$((HOSTNAME_ID + 1))

if [ ! -f "/tmp/zookeeper/myid" ]; then
    /opt/zookeeper/bin/zkServer-initialize.sh --myid=${MY_ID}
fi

/opt/zookeeper/bin/zkServer.sh start-foreground
