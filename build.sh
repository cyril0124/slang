#!/bin/bash

prj_dir=$(pwd)
build_dir=$prj_dir/build
install_dir=$prj_dir/install

rm -rf $build_dir
mkdir $build_dir

cd $build_dir; cmake .. \
-DCMAKE_C_COMPILER=gcc \
-DCMAKE_CXX_COMPILER=g++ \
-DBUILD_SHARED_LIBS=ON \
-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
-DCMAKE_INSTALL_PREFIX=$install_dir

cd $build_dir; make -j$(nproc)
cd $build_dir; make install
