#!/bin/bash
set -eou pipefail
DISTRO=${DISTRO:-fedora}
#command yaml2json >/dev/null || pip3 install json2yaml

tf=./.$DISTRO-docker-compose.yaml
#timeout 1 ./render_container_compose.sh > $tf
cmd="podman-compose -f $tf build"
ansi --yellow --italic "$cmd"
#exit
eval "$cmd"
exit
