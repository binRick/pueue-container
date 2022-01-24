#!/bin/bash
set -eou pipefail
DEBUG=${DEBUG:-0}
{
	source .envrc
	./render.sh
} >/dev/null
active_svcs() {
	while read -r svc; do
		echo -e "$svc"
	done < <(echo -e "$ACTIVE_SERVICES" | tr '[[:space:]]' '\n')
}
svcs() { ./services-ls.sh; }

while read -r svc; do
	if ! grep -q "^$svc$" <(active_svcs); then
		[[ "$DEBUG" == 1 ]] && ansi >&2 --red "Skipping service $svc"
	else
		echo -e "$svc"
	fi
done < <(svcs)
