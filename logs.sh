#!/bin/bash
set -eou pipefail
source .envrc
C=${1:-}

source render.sh >/dev/null

cmd="$CM-compose -f $CF logs --follow"
ansi >&2 --yellow --italic "$cmd"
eval "$cmd"
