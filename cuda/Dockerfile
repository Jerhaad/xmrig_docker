FROM ubuntu:20.04

LABEL maintainer="Jerhaad"

# USE YOUR TIMEZONE
# TODO: Automate
ARG TIMEZONE=America/Los_Angeles

# XMRig base version
ARG XMRIG_VER=6.12.2-mo2

# XMRig-CUDA version
ARG XMRIG_CUDA_VER=6.12.0

# Let the installs happen on their own
ENV DEBIAN_FRONTEND=noninteractive 

# One-off for tzdata
RUN set -xe; \
    apt update && apt upgrade -y; \
    ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime; \
    apt install -y tzdata; \
    dpkg-reconfigure --frontend noninteractive tzdata;

# Install CUDA
RUN set -xe; \
    apt-get update; \
    # apt-get upgrade -y; \
    apt-get install wget libxml2 linux-headers-$(uname -r) gnupg ubuntu-dev-tools software-properties-common -y; \
    # wget https://developer.download.nvidia.com/compute/cuda/11.2.0/local_installers/cuda_11.2.0_460.27.04_linux.run; \
    # sh cuda_11.2.0_460.27.04_linux.run; \
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin; \
    mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600; \
    # apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub; \
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub; \
    apt-key add 7fa2af80.pub; \ 
    add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"; \
    apt-get update; \
    apt-get -y install cuda;

# Install XMRig
RUN set -xe; \
    apt-get update && apt-get install build-essential cmake automake libtool autoconf -y; \
    wget https://github.com/MoneroOcean/xmrig/archive/refs/tags/v${XMRIG_VER}.tar.gz; \
    tar xf v${XMRIG_VER}.tar.gz; \
    mkdir -p xmrig-${XMRIG_VER}/build; \
    sed -i 's/DonateLevel = 1/DonateLevel = 0/g' xmrig-${XMRIG_VER}/src/donate.h; \
    cd xmrig-${XMRIG_VER}/scripts; \
    ./build_deps.sh; \
    cd ../build; \
    cmake .. -DXMRIG_DEPS=scripts/deps -DCMAKE_BUILD_TYPE=Release -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda; \
    make -j $(nproc); \
    cp xmrig /usr/local/bin/xmrig; \
    rm -rf xmrig* *.tar.gz;

# XMRig-CUDA install
RUN set -xe; \
    wget https://github.com/xmrig/xmrig-cuda/archive/refs/tags/v${XMRIG_CUDA_VER}.tar.gz; \
    tar xf v${XMRIG_CUDA_VER}.tar.gz; \
    mkdir -p xmrig-cuda-${XMRIG_CUDA_VER}/build; \
    cd xmrig-cuda-${XMRIG_CUDA_VER}/build; \
    cmake .. -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda; \
    make -j$(nproc); \
    cp libxmrig-cuda.so /usr/local/lib/libxmrig-cuda.so;

WORKDIR /tmp
COPY entrypoint.sh /
EXPOSE 3000
CMD ["/entrypoint.sh"]

