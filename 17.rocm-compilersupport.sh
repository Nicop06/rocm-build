#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/rocm-compilersupport
cd $ROCM_BUILD_DIR/rocm-compilersupport
pushd .

START_TIME=`date +%s`

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_DIR \
    -DCPACK_PACKAGING_INSTALL_PREFIX=$ROCM_INSTALL_DIR \
    -DCPACK_GENERATOR=TGZ \
    -G Ninja \
    $ROCM_GIT_DIR/ROCm-CompilerSupport/lib/comgr

cmake --build .
cmake --build . --target package
sudo tar xvf *.tar.gz --strip-components=1 -C /

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

