#!/bin/bash
set -eou pipefail
source .envrc
C=${1:-}

source render.sh >/dev/null

cmd="$CM-compose -f $CF ps --all"
ansi >&2 --yellow --italic "$cmd"
eval "$cmd"
