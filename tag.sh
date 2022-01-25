#!/bin/bash
set -eou pipefail
set -x

docker tag $DISTRO-pueue:latest docker.io/vpntechdockerhub/pueue:$DISTRO
docker tag $DISTRO-restic-rest-server:latest docker.io/vpntechdockerhub/pueue:$DISTRO-restic
