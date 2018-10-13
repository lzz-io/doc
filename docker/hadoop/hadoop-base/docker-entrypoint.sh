#!/bin/bash

set -e

echo 1

/usr/sbin/sshd -D

# tail -f /dev/null

echo 2

exec "$@"