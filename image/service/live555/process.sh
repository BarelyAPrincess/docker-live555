#!/bin/bash -e

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

# Reduce maximum number of number of open file descriptors to 1024
# otherwise slapd consumes two orders of magnitude more of RAM
# see https://github.com/docker/docker/issues/8231
ulimit -n 1024

set -x

exec /usr/local/bin/live555ProxyServer -h 8080 -p "$RTSP_PORT" -u "$USER" "$PASS" $STREAM_URL1 $STREAM_URL2 $STREAM_URL3 $STREAM_URL4
