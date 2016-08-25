#!/bin/sh

# If argument is given and it's available for execution in busybox shell.
# Check builtin, which and file is executable.
#
if [ -n "$1" ] && ( help | grep -qw "$1" || which $1 1>/dev/null || [ -x "$1" ] ); then
    eval "$@"
else
    # otherwise
    exec /usr/local/bin/nomad agent -config /config $@
fi
