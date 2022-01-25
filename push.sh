#!/bin/bash
set -eou pipefail; set -x
source .envrc.sh

echo -e "$DHP" | docker login docker.io -u vpntechdockerhub --password-stdin

docker push docker.io/vpntechdockerhub/pueue:$DISTRO
docker push docker.io/vpntechdockerhub/pueue:$DISTRO-restic
docker push docker.io/vpntechdockerhub/pueue:$DISTRO-ttyd
docker push docker.io/vpntechdockerhub/pueue:$DISTRO-gottyd
docker push docker.io/vpntechdockerhub/pueue:$DISTRO-iodine
