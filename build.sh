#!/bin/bash
set -eou pipefail
source .envrc

./git-pull.sh

git pull || git pull
DISTRO=${DISTRO:-fedora}
CM=${CM:-docker}
NC="${NC:-}"
command -v yaml2json >/dev/null || pip3 install json2yaml
command -v j2 >/dev/null || pip3 install j2cli

./render.sh

#tf=.$DISTRO-container-compose.yaml
#( ./render_container_compose.sh 2>&1 | tee $tf ) 2>/dev/null

#bc="$CM-compose --ansi always  -f $tf build --progress=tty --pull --force-rm"
#ansi --magenta --underline --italic "$bc"

#cmd="$CM-compose -f $tf pull && $CM-compose -f $tf build"
#ansi --yellow --italic "$cmd"

\cat $CF | yaml2json | jq '.services' | jq keys
cmd="docker-compose -f $CF build $NC --progress=tty --pull --force-rm"
ansi >&2 --yellow --italic "$cmd"

eval "$cmd"
