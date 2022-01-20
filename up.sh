#!/bin/bash
set -eou pipefail
source .envrc
C=${1:-}

tf=./.$DISTRO-docker-compose.yaml
./render_container_compose.sh 2>&1 | tee $tf
cmd="docker-compose -f $tf up --force-recreate --remove-orphans $C"
>&2 ansi --yellow --italic "$cmd"
eval "$cmd"
