#!/bin/bash
set -eou pipefail
source .envrc

./pull.sh

git pull||git pull
DISTRO=${DISTRO:-fedora}
CM=${CM:-docker}
command -v yaml2json >/dev/null || pip3 install json2yaml
command -v j2 >/dev/null || pip3 install j2cli

./render.sh

#tf=.$DISTRO-container-compose.yaml
#( ./render_container_compose.sh 2>&1 | tee $tf ) 2>/dev/null

\cat $tf|yaml2json|jq '.services' | jq keys




#bc="$CM-compose --ansi always  -f $tf build --progress=tty --pull --force-rm"
#ansi --magenta --underline --italic "$bc"

#cmd="$CM-compose -f $tf pull && $CM-compose -f $tf build"
#ansi --yellow --italic "$cmd"

NC="${NC:-}"

cmd="docker-compose -f $tf build $NC --progress=tty --pull --force-rm"

eval "$cmd"
