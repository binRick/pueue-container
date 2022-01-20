#!/bin/bash
set -eou pipefail
DISTRO=${DISTRO:-fedora}
cmd="command cat container-compose.yaml|sed 's/DF alpine.Dockerfile/DF $DISTRO.Dockerfile/g'|sed 's/IMG alpine-/IMG $DISTRO-/g'|yaml2json 2>/dev/null|json2yaml"
eval "$cmd"
cmd="command cat container-compose.yaml|sed 's/DF fedora.Dockerfile/DF $DISTRO.Dockerfile/g'|sed 's/IMG fedora-/IMG $DISTRO-/g'|yaml2json 2>/dev/null|json2yaml"
eval "$cmd"
