#!/bin/bash
set -eou pipefail
[[ "$ENVRC_LOADED" == 1 ]] || source .envrc
C=${1:-}

tf=./.$DISTRO-container-compose.yaml
Y="$(./render_container_compose.sh)"

Ym="$(echo -e "$Y" | yaml2json | jq '.services' | json2yaml)"
ansi --yellow --italic "$Ym"
echo -e "$Y" >$tf
