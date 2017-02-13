#!/bin/bash

DOCKER_MACHINE_NAME=$(docker-machine active)
[ -n "$DOCKER_MACHINE_NAME" ] && docker-machine ssh $DOCKER_MACHINE_NAME 'tce-status -i | grep -q dbus || tce-load -wi dbus'
[ -n "$DOCKER_MACHINE_NAME" ] && docker-machine ssh $DOCKER_MACHINE_NAME 'sudo /tmp/tcloop/dbus/usr/local/etc/init.d/dbus start'

