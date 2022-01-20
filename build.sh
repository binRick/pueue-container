#!/bin/bash
set -eou pipefail
DISTRO=${1:-fedora}

ccmd="docker-compose -f container-compose.yaml build"
eval "$ccmd"
exit

cmd="docker build -f $DISTRO.Dockerfile -t $DISTRO-pueue-container --target $DISTRO-pueue-container ."
eval "$cmd"
