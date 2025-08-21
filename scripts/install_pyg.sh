#!/usr/bin/env bash
set -e
MODE=${1:-cpu}   # use 'cpu' or 'cu121'
TORCH_VER=${2:-2.2.2}
TV_VER=${3:-0.17.2}

if [[ "$MODE" == "cpu" ]]; then
  pip install --index-url https://download.pytorch.org/whl/cpu torch==${TORCH_VER} torchvision==${TV_VER}
  pip install pyg-lib torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric     -f https://data.pyg.org/whl/torch-${TORCH_VER}+cpu.html
else
  pip install --index-url https://download.pytorch.org/whl/cu121 torch==${TORCH_VER} torchvision==${TV_VER}
  pip install pyg-lib torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric     -f https://data.pyg.org/whl/torch-${TORCH_VER}+cu121.html
fi
