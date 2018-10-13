#!/bin/bash

set -e


# Allow the container to be started with `--user`
if [[ "$1" = 'kafka-server-start.sh' && "$(id -u)" = '0' ]]; then
    chown -R "$APP_USER" "$APP_DATA_DIR"
    exec gosu "$APP_USER" "$0" "$@"
fi


# Generate the config only if it doesn't exist
if [[ ! -f "${APP_DATA_CONF_DIR}/server.properties" ]]; then
    CONFIG="${APP_DATA_CONF_DIR}/server.properties"

    # Server Basics
    echo "# Server Basics" >> "$CONFIG"   
    echo "broker.id=$BROKER_ID" >> "$CONFIG"

    # Socket Server Settings
    echo "# Socket Server Settings" >> "$CONFIG"
    echo "num.network.threads=3" >> "$CONFIG"
    echo "num.io.threads=8" >> "$CONFIG"
    echo "socket.send.buffer.bytes=102400" >> "$CONFIG"
    echo "socket.receive.buffer.bytes=102400" >> "$CONFIG"
    echo "socket.request.max.bytes=104857600" >> "$CONFIG"

    # Log Basics
    echo "# Log Basics" >> "$CONFIG"
    echo "log.dirs=$APP_DATA_LOG_DIR" >> "$CONFIG"
    echo "num.partitions=3" >> "$CONFIG"
    echo "num.recovery.threads.per.data.dir=3" >> "$CONFIG"

    # Internal Topic Settings
    echo "# Internal Topic Settings" >> "$CONFIG"
    echo "offsets.topic.replication.factor=3" >> "$CONFIG"
    echo "transaction.state.log.replication.factor=3" >> "$CONFIG"
    echo "transaction.state.log.min.isr=3" >> "$CONFIG"

    # Log Retention Policy
    echo "# Log Retention Policy" >> "$CONFIG"
    echo "log.retention.hours=168" >> "$CONFIG"
    echo "log.segment.bytes=1073741824" >> "$CONFIG"
    echo "log.retention.check.interval.ms=300000" >> "$CONFIG"

    # Zookeeper
    echo "# Zookeeper" >> "$CONFIG"
    echo "zookeeper.connect=$ZK_CONNECT" >> "$CONFIG"
    echo "zookeeper.connection.timeout.ms=6000" >> "$CONFIG"

    # Group Coordinator Settings
    echo "# Group Coordinator Settings" >> "$CONFIG"
    echo "group.initial.rebalance.delay.ms=0" >> "$CONFIG"

fi


exec "$@"