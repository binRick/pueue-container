#!/bin/bash
set -eou pipefail
DISTRO=${DISTRO:-fedora}
cmd="command cat container-compose.yaml|sed 's/alpine.Dockerfile/$DISTRO.Dockerfile/g'|sed 's/alpine-/$DISTRO-/g'|yaml2json 2>/dev/null|json2yaml"
#eval "$cmd"
#cmd="command cat container-compose.yaml|sed 's/fedora.Dockerfile/$DISTRO.Dockerfile/g'|sed 's/fedora-/$DISTRO-/g'|yaml2json 2>/dev/null|json2yaml"
eval "$cmd"
