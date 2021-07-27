FROM debian:buster

LABEL maintainer="Jerhaad"

# USE YOUR TIMEZONE
# TODO: Automate
ARG TIMEZONE=America/Los_Angeles

# XMRig base version
ARG XMRIG_VER=6.12.2-mo2

# Let the installs happen on their own
ENV DEBIAN_FRONTEND=noninteractive 

# PVE-headers are tough for some reason...
# TODO: Automate
# NOTE: This is only necessary to match the host's kernel
ARG PVE_VER=5.4.124-1
ARG PVE_ARCH=amd64
ARG PVE_BASE=buster

# One-off for tzdata
RUN set -xe; \
    apt update && apt upgrade -y; \
    ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime; \
    apt install -y tzdata; \
    dpkg-reconfigure --frontend noninteractive tzdata;

# Install Headers and prep
# TODO: make this dynamic.  Need to add (with keys, etc.) pve debian sources
RUN set -xe; \
    apt-get update; \
    apt-get install wget software-properties-common kmod msr-tools -y; \
    wget http://download.proxmox.com/debian/pve/dists/${PVE_BASE}/pve-no-subscription/binary-${PVE_ARCH}/pve-headers-${PVE_VER}-pve_${PVE_VER}_${PVE_ARCH}.deb; \
    dpkg -i pve-headers-${PVE_VER}-pve_${PVE_VER}_${PVE_ARCH}.deb;

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
    cmake .. -DXMRIG_DEPS=scripts/deps -DCMAKE_BUILD_TYPE=Release; \ 
    make -j $(nproc); \
    cp xmrig /usr/local/bin/xmrig; \
    rm -rf xmrig* *.tar.gz;

WORKDIR /tmp
COPY entrypoint.sh /
EXPOSE 3000
CMD ["/entrypoint.sh"]

