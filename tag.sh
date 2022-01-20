#!/bin/bash
set -eou pipefail
set -x
#docker rmi -f pueue
#podman build -f fedora.Dockerfile -t pueue --target pueue .


#docker tag localhost/pueue:latest docker.io/vpntechdockerhub/pueue:latest
#docker tag pueue docker.io/vpntechdockerhub/pueue:latest


docker push docker.io/vpntechdockerhub/pueue:latest
