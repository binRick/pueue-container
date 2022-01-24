#!/bin/bash
set -eou pipefail
source .envrc
C=${1:-}

source render.sh >/dev/null

cf=$tf

tfa=./.$DISTRO-container-compose-active.yaml
./services-generate.sh >$tfa
CF=$tfa

cmd="$CM-compose -f $CF ps --all"
ansi >&2 --yellow --italic "$cmd"
eval "$cmd"
