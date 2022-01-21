#!/bin/bash
set -eou pipefail
SVC=${1:-iodined0};shift||true
ARGS="${@:-sh}"

#cmd="docker run --privileged --rm -it --name $N  --volume /sys/fs/cgroup:/sys/fs/cgroup:ro $DISTRO-pueue $cmd"
tf=.$DISTRO-container-compose.yaml
./render_container_compose.sh > $tf
cmd="$CM-compose -f $tf run --name $SVC-run -p 18105:18105 -w /root  --rm -- $SVC $ARGS"
>&2 ansi --yellow --italic "$cmd"
eval "$cmd"
