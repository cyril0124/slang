#!/bin/bash

conda_cmd=conda
# conda_cmd=micromamba

$conda_cmd create -n cppenv python=3.8
$conda_cmd activate cppenv 

$conda_cmd install gcc_linux-64
$conda_cmd install gxx_linux-64 
$conda_cmd install libstdcxx-ng
$conda_cmd install conda-forge::gxx
$conda_cmd install conda-forge::boost

pip install conan

$conda_cmd deactivate
$conda_cmd activate cppenv 

which g++
which gcc
