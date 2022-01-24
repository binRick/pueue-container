#!/bin/bash
set -eou pipefail
DEBUG=${DEBUG:-0}
{
	source .envrc
	./render.sh
} >/dev/null
SVC=$1
M="^[[:space:]].*x-${SVC}:"

grep "$M" "container-compose.yaml" | grep ':' | head -n1 | cut -d: -f2 | sed 's/[[:space:]].*&//g'
