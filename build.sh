#!/bin/bash
set -eou pipefail
source .envrc
git pull||git pull
DISTRO=${DISTRO:-fedora}
CM=${CM:-docker}
#command -v yaml2json >/dev/null || pip3 install json2yaml

tf=.$DISTRO-container-compose.yaml

./render_container_compose.sh 2>&1 | tee $tf

bc="$CM-compose --ansi always  -f $tf build --no-cache --progress=tty --pull --force-rm"
ansi --magenta --underline --italic "$bc"

cmd="$CM-compose -f $tf pull && $CM-compose -f $tf build"
ansi --yellow --italic "$cmd"

NC="${NC:-}"

docker-compose -f $tf build $NC --progress=tty --pull --force-rm 

eval "$cmd"
