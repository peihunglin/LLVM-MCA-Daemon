#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

if [ -z "${WORKSPACE_PATH}" ]; then
WORKSPACE_PATH=/work
fi



# Inside Ubuntu 22.04 container
apt-get update
apt-get install -y build-essential flex bison libelf-dev libssl-dev \
                   libdw-dev libunwind-dev libslang2-dev

# Download the exact kernel source matching your host
wget --no-check-certificate  https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.14.tar.xz
tar -xf linux-5.14.tar.xz
cd linux-5.14/tools/perf

# Build perf
make prefix=${WORKSPACE_PATH}/perf install
