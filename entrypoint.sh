#!/bin/bash

# Use Bash as default command
if [ $# -eq 0 ]; then
   exec /bin/bash
fi

# If we were given arguments, override the default configuration
if [ $# -gt 0 ]; then
   service dbus start > dbus.log &&
   avahi-daemon --no-drop-root --daemonize && 
   args=$@
   args=$(echo $args | sed -e "s/{ID}/${id}/g")
   exec avahi-browse ${args}
   exit $?  # Make sure we really exit
fi
