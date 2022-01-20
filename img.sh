#!/bin/bash
set -eou pipefail
I=$1;shift
cmd="${@:-ls /etc}"

cmd="docker run --rm -it $I $cmd"
>&2 ansi --yellow --italic "$cmd"
eval "$cmd"
