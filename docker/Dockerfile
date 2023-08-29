FROM nvidia/cuda:11.1.1-devel-ubuntu20.04 as build

# Modify these to skip timezone selection
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN sed -i s/archive.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list \
    && sed -i s/security.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list
RUN apt update

# build python from source code
WORKDIR /root
RUN apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev lzma liblzma-dev wget -y
RUN apt install git libgl1-mesa-glx ffmpeg libsm6 libxext6 libbz2-dev -y
RUN apt install python-tk python3-tk tk-dev -y
RUN mkdir /root/env
WORKDIR /root/env
RUN wget https://npm.taobao.org/mirrors/python/3.8.17/Python-3.8.17.tgz
RUN tar -xzf Python-3.8.17.tgz
WORKDIR /root/env/Python-3.8.17
RUN ./configure --enable-optimizations
RUN make -j 32 && make altinstall
# create links for easy use
RUN rm /usr/bin/python*
RUN ln -s /usr/local/bin/python3.8 /usr/bin/python3.8
RUN ln -s /usr/local/bin/python3.8 /usr/bin/python3
RUN ln -s /usr/local/bin/python3.8 /usr/bin/python
RUN ln -s /usr/local/bin/pip3.8 /usr/bin/pip3.8
RUN ln -s /usr/local/bin/pip3.8 /usr/bin/pip
RUN ln -s /usr/local/bin/pip3.8 /usr/bin/pip3

# install python packages
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install --upgrade pip
RUN pip install wheel
RUN pip install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
# mmcv-full version1.6.0 must be installed in this way, otherwise mmcv-related errors will be triggered
RUN pip install mmcv-full==1.6.0 -f https://download.openmmlab.com/mmcv/dist/cu111/torch1.9.0/index.html
RUN pip install mmdet==2.24.0
RUN pip install mmsegmentation==0.29.1
RUN pip install mmdet3d==1.0.0rc5
RUN pip install spconv-cu111==2.1.21
RUN pip install flash-attn==0.2.2
RUN pip install numpy==1.23.5

WORKDIR /