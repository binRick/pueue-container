#!/bin/bash
set -eou pipefail

docker build -f fedora.Dockerfile -t pueue-container --target pueue-container .
