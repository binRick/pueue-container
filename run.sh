#!/bin/bash
set -eou pipefail
DISTRO=${DISTRO:-fedora};shift||true
N=$DISTRO-c0
cmd="${@:-ls /etc}"

cmd="docker run --privileged --rm -it --name $N  --volume /sys/fs/cgroup:/sys/fs/cgroup:ro $DISTRO-pueue $cmd"
cmd="docker-compose -f container-compose.yaml up"
>&2 ansi --yellow --italic "$cmd"
eval "$cmd"
