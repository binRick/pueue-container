echo -n '{"parameters":{"param1":"-al","param2":"/tmp"}}' | http POST localhost:39775/ls \
        Signature:'sha1=d762407ca7fb309dfbeb73c080caf6394751f0a4' \
        Authorization:'Basic dGVzdDp0ZXN0dGVzdA=='
