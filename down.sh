#!/bin/bash
set -eou pipefail
DISTRO=${1:-fedora};shift||true
N=$DISTRO-c0
cmd="${@:-ls /etc}"

cmd="docker-compose -f container-compose.yaml down"
>&2 ansi --yellow --italic "$cmd"
eval "$cmd"
