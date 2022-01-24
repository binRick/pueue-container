#!/bin/bash
set -eou pipefail
{
	source .envrc
	./render.sh
} >/dev/null
\cat container-compose.yaml | yaml2json | jq '.["x-disabledservices"]' | jq keys -Mr | grep '"' | cut -d'"' -f2 | sort -u | grep '^x-[a-z]' | cut -d'-' -f2-100
