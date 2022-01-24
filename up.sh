#!/bin/bash
set -eou pipefail
source .envrc

C=${1:-}

if [[ "$C" == "active" ]]; then
	C="$(./services-ls-active.sh | tr '\n' ' ')"
fi

tf=./.$DISTRO-container-compose.yaml
tfa=.$DISTRO-container-compose-active.yaml
#./render_container_compose.sh 2>&1 > $tf
./render.sh
cf=$tf
./services-generate.sh >$tfa
cf=$tfa
cmd="$CM-compose -f $cf up --force-recreate --remove-orphans --build $C"
ansi >&2 --yellow --italic "$cmd"
#eval "$cmd"
