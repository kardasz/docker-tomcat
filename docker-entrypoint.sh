#!/bin/bash

set -e

if [ "${1:0:1}" = '-' ]; then
	set -- catalina.sh "$@"
fi

if [ "$1" = 'catalina.sh' ]; then
	exec gosu tomcat "$@"
fi

exec "$@"