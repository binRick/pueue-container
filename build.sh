#!/bin/bash
set -eou pipefail
source .envrc
git pull||git pull
DISTRO=${DISTRO:-fedora}
CM=${CM:-docker}
#command yaml2json >/dev/null || pip3 install json2yaml

tf=./.$DISTRO-docker-compose.yaml
./render_container_compose.sh 2>&1 | tee $tf
cmd="$CM-compose -f $tf build"
ansi --yellow --italic "$cmd"
#exit
eval "$cmd"
#exit
