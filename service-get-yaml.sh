#!/bin/bash
set -eou pipefail
DEBUG=${DEBUG:-0}
{
	source .envrc
	./render.sh
} >/dev/null
SVC=$1
M="^[[:space:]].*x-${SVC}:"

M=".[\"x-$SVC\"]"

OFFSET=""

#\cat $CF|grep '^services:$' -B 9999

#while read -r l; do
#	echo -e "${OFFSET}${l}"
#done < <(
\cat container-compose.yaml | yaml2json | jq '.["x-disabledservices"]' | jq "$M" | json2yaml
