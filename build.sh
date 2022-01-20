#!/bin/bash
set -eou pipefail
DISTRO=${DISTRO:-fedora}

ccmd="docker-compose -f container-compose.yaml build"
eval "$ccmd"
exit

cmd="docker build -f $DISTRO.Dockerfile -t $DISTRO-pueue-container --target $DISTRO-pueue-container ."
eval "$cmd"
