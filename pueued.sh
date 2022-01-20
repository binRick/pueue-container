#!/bin/bash
set -eou pipefail
DISTRO=${DISTRO:-fedora};shift||true
N=pueued0
cmd="${@:-ls /etc}"

cmd="docker-compose -f container-compose.yaml up --force-recreate --remove-orphans $N"
>&2 ansi --yellow --italic "$cmd"
eval "$cmd"
