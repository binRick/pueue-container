#!/bin/bash
set -eou pipefail
source .envrc
C=${1:-}

tf=./.$DISTRO-container-compose.yaml
./render_container_compose.sh 2>&1 | tee $tf
cmd="$CM-compose -f $tf up --force-recreate --remove-orphans $C"
>&2 ansi --yellow --italic "$cmd"
eval "$cmd"
