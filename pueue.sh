#!/bin/bash
set -eou pipefail
source .envrc
C=${@:-status}
docker ps
cmd="docker exec pueue-container_pueued0_1 /bin/pueue $C"
ansi >&2 --yellow --italic "$cmd"
eval "$cmd"
