#!/bin/bash
set -eou pipefail
DISTRO=${DISTRO:-fedora}
CM=${CM:-docker}
#command yaml2json >/dev/null || pip3 install json2yaml

tf=./.$DISTRO-docker-compose.yaml
./render_container_compose.sh | tee $tf
cmd="$CM-compose -f $tf build"
ansi --yellow --italic "$cmd"
#exit
eval "$cmd"
#exit
