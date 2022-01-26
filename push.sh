#!/bin/bash
set -eou pipefail; set -x
source .envrc.sh

echo -e "$DHP" | docker login docker.io -u vpntechdockerhub --password-stdin

docker push docker.io/vpntechdockerhub/pueue:$DISTRO
for x in restic ttyd gottyd iodined guard; do
  docker push docker.io/vpntechdockerhub/pueue:$DISTRO-$x &
done
wait


