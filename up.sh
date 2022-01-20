#!/bin/bash
set -eou pipefail
N=$1;shift
cmd="${@:-ls /etc}"

cmd="docker-compose -f container-compose.yaml up --force-recreate --remove-orphans $N"
>&2 ansi --yellow --italic "$cmd"
eval "$cmd"
