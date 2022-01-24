#!/usr/bin/env bash
set -eou pipfail
set -x
ARGS="${@}"

iptables -I INPUT -s 
echo 1 > /proc/sys/net/ipv4/ip_forward
cat /proc/sys/net/ipv4/ip_forward

cmd="$ARGS"
exec $cmd
