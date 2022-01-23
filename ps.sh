#!/bin/bash
set -eou pipefail
source .envrc
C=${1:-}

source render.sh >/dev/null

cmd="$CM-compose -f $CF ps --all"
>&2 ansi --yellow --italic "$cmd"
eval "$cmd"
