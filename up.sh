#!/bin/bash
set -eou pipefail
source .envrc
C=${1:-}

tf=./.$DISTRO-container-compose.yaml
./render_container_compose.sh 2>&1 | tee $tf
cmd="$CM-compose -f $tf up --force-recreate --remove-orphans --build $C"
ansi >&2 --yellow --italic "$cmd"
eval "$cmd"
