#!/usr/bin/env bash
set -eou pipefail
set -x
ARGS="${@}"

#iptables -I INPUT -s 
cat /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv4/ip_forward
cat /proc/sys/net/ipv4/ip_forward
cmd="$(command -v iodined) -d $DTUN_DEVICE -p $DTUN_PORT -f -c -i 300 -D $DTUN_CIDR $DTUN_DOMAIN"


eval $cmd
