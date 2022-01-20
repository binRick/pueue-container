#!/bin/bash
set -eou pipefail
DISTRO=${DISTRO:-fedora}
#command yaml2json >/dev/null || pip3 install json2yaml

tf=./.$DISTRO-docker-compose.yaml
./render_container_compose.sh | tee $tf
cmd="podman-compose -f $tf build"
ansi --yellow --italic "$cmd"
#exit
eval "$cmd"
#exit
