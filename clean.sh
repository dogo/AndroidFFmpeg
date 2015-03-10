#!/bin/bash

pushd external/x264
make clean

popd
pushd external/freetype2
make clean

popd
pushd external/ffmpeg
make clean

popd