# Mount the data folder
# -v /home/era/code/EasyMocap/data/examples:/home/user/easymocap/EasyMocap/data/examples \

docker run \
    --rm \
    --network=host \
    --gpus all \
    eradorta/openpose
