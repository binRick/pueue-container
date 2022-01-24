#!/bin/bash
set -eou pipefail
set -x

docker tag $DISTRO-pueue:latest docker.io/vpntechdockerhub/pueue:$DISTRO
