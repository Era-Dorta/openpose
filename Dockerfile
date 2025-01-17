FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES video,compute,utility
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install required Packages
RUN set -xe && \
        apt-get update && \
        apt-get install --no-install-recommends  -y \
                        git sudo wget \
                        build-essential \
                        ffmpeg \
                        gdebi \
                        libopencv-dev \
                        cmake && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

# Build OpenPose
WORKDIR /
RUN set -xe && \
        git clone https://github.com/Era-Dorta/openpose.git

WORKDIR /openpose/
       
RUN bash ./scripts/ubuntu/install_deps.sh

# Copy the openpose models
ARG OPENPOSE_MODELS
ADD ${OPENPOSE_MODELS} ./models

RUN mkdir -p /openpose/build && \
        cd /openpose/build && \
        cmake .. && \
        make -j$(nproc) && \
        make install

WORKDIR /usr/local
RUN set -xe && \
        ln -s /openpose/build/examples/openpose/openpose.bin /bin/openpose.bin

RUN pip3 install flask

ENTRYPOINT ["python3", "/openpose/flask/flask_entrypoint.py"]