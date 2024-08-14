#!/bin/bash
REPO_DIR=$(dirname $(dirname $(realpath $0)))

cd $REPO_DIR

docker build \
    --progress=plain \
    --tag eradorta/openpose \
    ${REPO_DIR}
