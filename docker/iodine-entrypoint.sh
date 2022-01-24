#!/usr/bin/env bash
set -eou pipefail
set -x
ARGS="${@:-}"
PID_FILE=/tmp/iodine.pid
#iptables -I INPUT -s 
cmd="$(command -v iodine) -d $DTUN_DEVICE -4 -f -F $PID_FILE $DTUN_DOMAIN"

>&2 echo -e "$cmd"
eval $cmd
