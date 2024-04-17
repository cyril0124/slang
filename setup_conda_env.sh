#!/bin/bash

conda create -n gccenv python=3.8
conda activate gccenv

conda install gcc_linux-64
conda install gxx_linux-64 
conda install libstdcxx-ng
conda install conda-forge::gxx

pip install conan

conda deactivate
conda activate gccenv

which g++
which gcc
