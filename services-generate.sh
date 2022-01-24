#!/bin/bash
set -eou pipefail
DEBUG=${DEBUG:-0}
{
	source .envrc
	./render.sh
} >/dev/null

doit() {
	(
		\cat $CF | grep '^services:$' -B 9999
		while read -r svc; do
			y="$(./service-get-yaml.sh $svc)"
			echo -e "\n $svc:\n$y\n"
		done < <(./services-ls-active.sh)
		#| yaml2json | json2yaml
	) | stdbuf -oL cat
	#|yaml2json|json2yaml
}

doit
