# 使用官方 CUDA devel 镜像作为基础
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

# 设置一些环境变量，避免安装过程中的交互式提问
ENV DEBIAN_FRONTEND=noninteractive

# 切换为 root 用户以进行安装
USER root

# 1. 更新包列表并安装 apt 依赖 (git-lfs, ffmpeg, wget)
RUN apt-get update && apt-get install -y \
    git-lfs \
    ffmpeg \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 2. 下载并安装 Miniconda
# 将 Miniconda 安装到 /opt/conda 目录
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

# 3. 将 Conda 添加到系统环境变量 PATH 中
ENV PATH=/opt/conda/bin:$PATH

# (可选) 初始化 git-lfs
RUN git lfs install

# (可选) 验证 Conda 是否安装成功
RUN conda --version

# 接受 Anaconda 的条款和条件
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

# (可选) 创建一个 Conda 环境
RUN conda create -n pb_diff python=3.9 -y

# 激活环境
RUN /bin/bash -c "source activate pb_diff"

# 运行安装脚本
COPY install_torch.sh /install_torch.sh
RUN /bin/bash /install_torch.sh && rm /install_torch.sh

# 在这里添加你自己的其他指令，例如复制项目代码等
# WORKDIR /app
# COPY . .

# 设置容器启动时默认执行的命令
# 让容器保持运行，以便你可以通过 exec 进入
CMD [ "tail", "-f", "/dev/null" ]