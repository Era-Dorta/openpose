#!/bin/bash
REPO_DIR=$(dirname $(dirname $(realpath $0)))

cd $REPO_DIR

VERSION=$(grep -oP '(?<=const std::string OPEN_POSE_VERSION_STRING = ")[^"]*' include/openpose/core/macros.hpp)

# Mount the data folder
# -v /home/era/code/EasyMocap/data/examples:/home/user/easymocap/EasyMocap/data/examples \

docker run \
    --rm \
    --network=host \
    --gpus all \
    eradorta/openpose:$VERSION
