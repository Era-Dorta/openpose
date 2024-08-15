#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Must provide your github username as argument"
    exit 1
fi

REPO_DIR=$(dirname $(dirname $(realpath $0)))

cd $REPO_DIR

VERSION=$(grep -oP '(?<=const std::string OPEN_POSE_VERSION_STRING = ")[^"]*' include/openpose/core/macros.hpp)

apptainer registry login --username $1 oras://ghcr.io
apptainer push openpose-${VERSION}.sif oras://ghcr.io/era-dorta/openpose:${VERSION}