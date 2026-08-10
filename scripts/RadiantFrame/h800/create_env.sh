#!/bin/bash

# ######################################## SET CUDA ENV ########################################
echo "=== CUDA environment set ==="

CUDA_DIR=/usr/local/cuda-13.0

export LD_LIBRARY_PATH=${CUDA_DIR}/lib64:${LD_LIBRARY_PATH}

export CUDA_HOME=${CUDA_DIR}

export PATH=${CUDA_DIR}/bin:${PATH}

echo $(nvcc -V)

# ######################################## CREATE UV ENV ########################################
echo "=== CREATE UV Environment ==="

# install uv environment
# curl -LsSf https://astral.sh/uv/install.sh | sh

# way 1: H800
#-------------------------------------------------------------------------------
# export UV_INDEX_URL=https://mirrors.aliyun.com/pypi/simple
export UV_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
# Do NOT add pypi.org as an extra index: uv's unsafe-best-match strategy queries
# every index per-package, so an extra pypi.org makes each resolve hit the
# (slow/blocked from CN) official PyPI and time out. Use aliyun only; install any
# truly-missing package from pypi manually instead of opening a global extra index.
# export UV_EXTRA_INDEX_URL=https://pypi.org/simple

# create a virtual environment
uv venv --python 3.12 --seed
# activate the virtual environment
source .venv/bin/activate

uv pip install accelerate transformers torchvision

# from source
# change [[tool.uv.index]] from default to "https://mirrors.aliyun.com/pypi/simple"?
uv pip install -e ".[torch]"