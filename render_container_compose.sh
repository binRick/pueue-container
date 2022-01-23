#!/bin/bash
set -eou pipefail
DISTRO=${DISTRO:-fedora}
if [[ "$DISTRO" == fedora ]]; then
  cmd="command cat container-compose.yaml|sed 's/alpine/$DISTRO/g'|yaml2json 2>/dev/null|json2yaml"
else
  cmd="command cat container-compose.yaml|sed 's/fedora/$DISTRO/g'|yaml2json 2>/dev/null|json2yaml"
fi

tf=$(mktemp)
tf1=$(mktemp)
eval "$cmd" > $tf

j2_cmd="j2 -f env -o $tf1 $tf"
eval $j2_cmd



cat $tf1
unlink $tf 
unlink $tf1
