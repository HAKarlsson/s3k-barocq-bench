#!/usr/bin/env bash

docker build -t s3k-toolchain --ssh default .devcontainer
docker run -it --rm -v .:/workdir -w /workdir s3k-toolchain
