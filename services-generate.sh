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
			echo -e "    $svc:\n$(./service-get-yaml.sh $svc)\n"
		done < <(./services-ls-active.sh)
		#| yaml2json | json2yaml
	) | stdbuf -oL cat
	#|yaml2json|json2yaml
}

doit
