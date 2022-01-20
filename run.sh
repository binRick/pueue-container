#!/bin/bash
set -eou pipefail
DISTRO=${1:-fedora};shift||true
N=$DISTRO-c0
cmd="${@:-ls /etc}"


cmd="docker run --privileged --rm -it --name $N  --volume /sys/fs/cgroup:/sys/fs/cgroup:ro $DISTRO-pueue-container $cmd"
>&2 ansi --yellow --italic "$cmd"
eval "$cmd"
