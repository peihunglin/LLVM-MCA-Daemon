#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

if [ -z "${WORKSPACE_PATH}" ]; then
WORKSPACE_PATH=/work
fi

mkdir -p ${WORKSPACE_PATH}/mcad-build
mkdir -p ${WORKSPACE_PATH}/mcad-install
cd ${WORKSPACE_PATH}/mcad-build

cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=${WORKSPACE_PATH}/mcad-install \
               -DCMAKE_C_COMPILER=clang-21 -DCMAKE_CXX_COMPILER=clang++-21 \
               -DLLVM_DIR=${WORKSPACE_PATH}/llvm-install/lib/cmake/llvm \
               -DLLVM_MCAD_ENABLE_PLUGINS="tracer;qemu" \
               -DQEMU_INCLUDE_DIR=${WORKSPACE_PATH}/qemu/include \
               ${WORKSPACE_PATH}/LLVM-MCA-Daemon
ninja
ninja install
