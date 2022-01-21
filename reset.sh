#!/bin/bash
set +e
docker ps -aq|xargs -I % docker rm -f %
podman ps -aq|xargs -I % podman rm -f %
docker images -aq|xargs -I % docker rmi -f %
podman images -aq|xargs -I % podman rmi -f %
docker ps -aq|xargs -I % docker rm -f %
