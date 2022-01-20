#!/bin/bash
set -eou pipefail
DISTRO=${DISTRO:-fedora}

tf=./.$DISTRO-docker-compose.yaml
./render_container_compose.sh > $tf
cmd="docker-compose -f $tf build"
ansi --yellow --italic "$cmd"
exit
eval "$cmd"
exit
