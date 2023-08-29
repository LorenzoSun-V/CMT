docker build -t cmt .
docker run --ipc=host -it \
           --name cmt \
           --gpus all \
           --privileged \
           --rm \
           cmt:latest  /bin/bash