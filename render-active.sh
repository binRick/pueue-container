#!/bin/bash
set -eou pipefail
[[ "$ENVRC_LOADED" == 1 ]] || source .envrc
tf=./.$DISTRO-container-compose-active.yaml
./services-generate.sh > $tf
