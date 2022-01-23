#!/bin/bash
set -eou pipefail
source .envrc
source setup-python.sh

command -v yaml2json >/dev/null || pip3 install json2yaml
command -v j2 >/dev/null || pip3 install j2cli

./render.sh
