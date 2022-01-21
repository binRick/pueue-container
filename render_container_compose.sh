#!/bin/bash
set -eou pipefail
DISTRO=${DISTRO:-fedora}
if [[ "$DISTRO" == fedora ]]; then
  cmd="command cat container-compose.yaml|sed 's/alpine/$DISTRO/g'|yaml2json 2>/dev/null|json2yaml"
else
  cmd="command cat container-compose.yaml|sed 's/fedora/$DISTRO/g'|yaml2json 2>/dev/null|json2yaml"
fi
#eval "$cmd"
#cmd="command cat container-compose.yaml|sed 's/fedora.Dockerfile/$DISTRO.Dockerfile/g'|sed 's/fedora-/$DISTRO-/g'|yaml2json 2>/dev/null|json2yaml"
eval "$cmd"
