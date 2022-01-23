#!/bin/bash
set -eou pipefail
I=$1
shift
cmd="${@:-ls /etc}"

cmd="docker run --rm -it $I $cmd"
ansi >&2 --yellow --italic "$cmd"
eval "$cmd"
