#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/rocm-core
cd $ROCM_BUILD_DIR/rocm-core
pushd .

START_TIME=`date +%s`

cmake \
  -DCMAKE_INSTALL_PREFIX=${ROCM_INSTALL_DIR} \
  -DPROJECT_VERSION_MAJOR=${ROCM_MAJOR_VERSION} \
  -DPROJECT_VERSION_MINOR=${ROCM_MINOR_VERSION} \
  -DPROJECT_VERSION_PATCH=${ROCM_PATCH_VERSION} \
  -DROCM_PATCH_VERSION=${ROCM_LIBPATCH_VERSION} \
  -DROCM_BUILD_VERSION=${CPACK_DEBIAN_PACKAGE_RELEASE} \
  -DCPACK_GENERATOR=TGZ \
  $ROCM_BUILD_DIR/../src/rocm-core

cmake --build . --target package
sudo tar xvf *.tar.gz --strip-components=1 -C /

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

