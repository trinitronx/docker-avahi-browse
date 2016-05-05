FROM debian:jessie
MAINTAINER hsfeng <hsfeng@gmail.com>

# install necessary stuff; avahi, and ssh such that we can log in and control avahi
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y avahi-daemon avahi-utils dbus\
  && apt-get -qq -y autoclean \
  && apt-get -qq -y autoremove \
  && apt-get -qq -y clean

ADD avahi-daemon.conf /etc/avahi/avahi-daemon.conf

# workaround to get dbus working, required for avahi to talk to dbus. This will be mounted
RUN mkdir -p /var/run/dbus
VOLUME /var/run/dbus

# login keys come in through a volume; we intend to log into root on this to run commands
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD []
