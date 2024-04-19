#!/bin/bash

prj_dir=$(dirname $(realpath $0))

export PATH=$prj_dir/install/bin:$PATH
export LD_LIBRARY_PATH=$prj_dir/install/lib:$LD_LIBRARY_PATH
export SLANG_HOME=$prj_dir
