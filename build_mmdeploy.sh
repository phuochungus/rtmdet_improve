#!/bin/bash

cd mmdeploy

mkdir -p build && cd build

cmake .. \
    -DMMDEPLOY_CODEBASES="mmdet" \
    -DMMDEPLOY_BUILD_SDK=ON \
    -DMMDEPLOY_TARGET_DEVICES=cpu \
    -DMMDEPLOY_TARGET_BACKENDS=ort \
    -DONNXRUNTIME_DIR=$ONNXRUNTIME_DIR \

make -j$(nproc) && make install
