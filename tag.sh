#!/bin/bash
set -eou pipefail
set -x

docker tag $DISTRO-pueue:latest docker.io/vpntechdockerhub/pueue:$DISTRO
docker tag $DISTRO-restic-rest-server:latest docker.io/vpntechdockerhub/pueue:$DISTRO-restic
docker tag $DISTRO-ttyd:latest docker.io/vpntechdockerhub/pueue:$DISTRO-ttyd
docker tag $DISTRO-gottyd:latest docker.io/vpntechdockerhub/pueue:$DISTRO-gottyd
docker tag $DISTRO-iodine:latest docker.io/vpntechdockerhub/pueue:$DISTRO-iodine
docker tag $DISTRO-guard:latest docker.io/vpntechdockerhub/pueue:$DISTRO-guard
