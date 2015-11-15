#!/bin/sh

set -ue

if [ $# -ne 3 ]; then
	echo "Usage: `basename $0` user host port" 1>&2
	exit 1
fi

user="$1"
host="$2"
port="$3"

ssh-keygen -f "$HOME/.ssh/id_rsa" -N '' > /dev/null
cat "$HOME/.ssh/id_rsa.pub"

while :; do
	ssh \
		-o UserKnownHostsFile=/dev/null \
		-o StrictHostKeyChecking=no \
		-D 0.0.0.0:1080 \
		-N \
		-p "$port" \
		"$user@$host" \
		|| true

	sleep 10
done
