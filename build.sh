#!/bin/bash
set -eou pipefail

podman build -f fedora.Dockerfile -t pueue-container --target pueue-container .
