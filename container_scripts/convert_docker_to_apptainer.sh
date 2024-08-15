#!/bin/bash
REPO_DIR=$(dirname $(dirname $(realpath $0)))

cd $REPO_DIR

VERSION=$(grep -oP '(?<=const std::string OPEN_POSE_VERSION_STRING = ")[^"]*' include/openpose/core/macros.hpp)

apptainer build openpose-${VERSION}.sif docker-daemon:docker.io/eradorta/openpose:${VERSION}
