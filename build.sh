#!/bin/bash
set -eou pipefail
DISTRO=${1:-fedora}

cmd="docker build -f $DISTRO.Dockerfile -t $DISTRO-pueue-container --target $DISTRO-pueue-container ."
eval "$cmd"
