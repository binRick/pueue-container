#!/bin/bash
set -eou pipefail
set -x
#docker rmi -f pueue-container
#podman build -f fedora.Dockerfile -t pueue-container --target pueue-container .


#docker tag localhost/pueue-container:latest docker.io/vpntechdockerhub/pueue:latest
#docker tag pueue-container docker.io/vpntechdockerhub/pueue:latest


docker push docker.io/vpntechdockerhub/pueue:latest
