#!/bin/bash
set -eou pipefail
SVC=$1;shift
ARGS="${@:-sh}"

#cmd="docker run --privileged --rm -it --name $N  --volume /sys/fs/cgroup:/sys/fs/cgroup:ro $DISTRO-pueue $cmd"
#cmd="docker-compose -f container-compose.yaml up"
tf=.$DISTRO-container-compose.yaml
./render_container_compose.sh > $tf
cmd="$CM-compose -f $tf run --name c11 -w /root  --rm -- iodined0 $ARGS"
>&2 ansi --yellow --italic "$cmd"
eval "$cmd"
