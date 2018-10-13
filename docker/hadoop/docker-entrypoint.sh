#!/bin/bash

set -e

/usr/sbin/sshd

# Allow the container to be started with `--user`
if [[ "$1" = 'start-all.sh' && "$(id -u)" = '0' ]]; then
    chown -R "$APP_USER" "$APP_DATA_DIR"
    exec gosu "$APP_USER" "$0" "$@"
fi


exec "$@"