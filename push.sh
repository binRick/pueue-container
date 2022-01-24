#!/bin/bash
set -eou pipefail; set -x
echo -e "$DHP" | docker login docker.io -u vpntechdockerhub --password-stdin
docker push docker.io/vpntechdockerhub/pueue:$DISTRO
