#!/bin/bash

conda create -n cppenv python=3.8
conda activate cppenv 

conda install gcc_linux-64
conda install gxx_linux-64 
conda install libstdcxx-ng
conda install conda-forge::gxx
conda install conda-forge::boost

pip install conan

conda deactivate
conda activate cppenv 

which g++
which gcc
