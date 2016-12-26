#!/bin/sh

set -ue

if [ $# -ne 3 ]; then
	echo "Usage: `basename $0` user host port" 1>&2
	exit 1
fi

user="$1"
host="$2"
port="$3"

# https://blog.g3rt.nl/upgrade-your-ssh-keys.html
private_key="$HOME/.ssh/id_ed25519"
if [ ! -f "$private_key" ]; then
	ssh-keygen -o -a 100 -t ed25519 -N '' -f "$private_key" > /dev/null
fi

cat "$private_key.pub"

while :; do
	ssh \
		-C \
		-N \
		-o UserKnownHostsFile=/dev/null \
		-o StrictHostKeyChecking=no \
		-D 0.0.0.0:1080 \
		-l "$user" \
		-p "$port" \
		"$host" \
		|| true

	echo DISCONNECTED

	sleep 10
done
