FROM ubuntu:24.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential git make bc bison flex libssl-dev libelf-dev \
    device-tree-compiler qemu-system-arm qemu-system-aarch64 \
    u-boot-tools binutils gcc-aarch64-linux-gnu python3 python3-pip \
    trace-cmd vim less file && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash"]
