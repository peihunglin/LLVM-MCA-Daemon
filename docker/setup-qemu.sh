#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

if [ -z "${WORKSPACE_PATH}" ]; then
WORKSPACE_PATH=/work
fi

# Run ./setup-deps.sh before this to install dependencies needed to build LLVM

# Applying the patches requires that our git user has an identity.
git config --global user.email "workflow@example.com"
git config --global user.name "Workflow"
git clone https://gitlab.com/qemu-project/qemu.git 
cd qemu
git checkout 0cef06d18762374c94eb4d511717a4735d668a24
git apply ${WORKSPACE_PATH}/LLVM-MCA-Daemon/plugins/qemu-broker/patches/qemu-patch.diff
mkdir build && cd build
../configure --target-list="aarch64-linux-user,arm-linux-user,x86_64-linux-user,ppc64-linux-user,ppc64le-linux-user,ppc-linux-user,riscv64-linux-user,riscv32-linux-user" \
             --enable-capstone \
             --enable-debug \
             --enable-plugins
ninja qemu-arm qemu-x86_64 qemu-aarch64 qemu-ppc{,64,64le} qemu-riscv64 qemu-riscv32
ninja install
