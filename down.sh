#!/bin/bash
set -eou pipefail
DISTRO=${1:-fedora}
shift || true
N=$DISTRO-c0
cmd="${@:-ls /etc}"

cmd="docker-compose -f $CF down --remove-orphans"
ansi >&2 --yellow --italic "$cmd"
eval "$cmd"
