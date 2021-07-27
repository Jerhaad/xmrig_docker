#!/bin/sh

if [ -f build.log ]; then
    rm build.log
fi

docker build --tag monero_cuda_local . > build.log &

tail -f build.log
