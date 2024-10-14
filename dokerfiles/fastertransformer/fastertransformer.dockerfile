# 使用具有 CUDA 11.0 的基础镜像
# FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04
# FROM python:3.8-slim
FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# 安装基本工具和依赖

RUN sed -i s:/archive.ubuntu.com:/mirrors.tuna.tsinghua.edu.cn/ubuntu:g /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*
RUN python3 --version
RUN nvcc --version
# 安装 PyTorch 1.8.0
RUN python3 -m pip install --upgrade pip
RUN pip3 install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 -f https://mirrors.aliyun.com/pytorch-wheels/cu113/ -i https://pypi.tuna.tsinghua.edu.cn/simple/

# 验证 CMake 版本
RUN cmake --version

# 将工作目录设置为 /app
WORKDIR /app

# 复制项目文件到容器中（根据需要复制，如有需要请修改）
COPY FasterTransformer /app/FasterTransformer

# CMD ["python3"]  # 可根据需求添加
