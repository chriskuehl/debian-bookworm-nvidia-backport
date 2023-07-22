FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y \
        build-essential \
        debhelper-compat \
        devscripts \
        dh-dkms \
        dh-exec \
        dh-sequence-dkms \
        libglvnd-dev \
        libnvidia-egl-wayland1 \
        libvulkan1 \
        libxext6 \
        $(test $(dpkg --print-architecture) = 'amd64' && echo 'linux-headers-amd64' || echo '') \
        po-debconf \
        quilt \
        zstd \
    && apt-get clean
