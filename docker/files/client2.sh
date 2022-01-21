#!/usr/bin/env bash
set -eou pipefail
set -x
http GET http://127.0.0.1:39775/ls Authorization:'Basic dGVzdDp0ZXN0dGVzdA=='
