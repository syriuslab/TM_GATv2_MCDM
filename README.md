# Fusion-WSN: Single-Notebook Reproducibility

This repository reproduces the pipeline from the paper **Trust-Aware Graph Learning for IoT/WSN** using a **single notebook**:
- `notebooks/TrustGNN_Fused_Pipeline_RIG.ipynb`

The layout mirrors the simplicity of `fusion_framework`, but **no notebook splitting** is required.

## Structure
```
.
├── data/
│   ├── raw/         # place/download the 4 public datasets here
│   └── processed/   # generated artifacts (splits, standardized arrays, graphs)
├── models/          # trained checkpoints (GNN, scalers) [optional]
├── outputs/         # metrics, plots, tables exported by the notebook
├── notebooks/
│   └── TrustGNN_Fused_Pipeline_RIG.ipynb
├── scripts/
│   ├── install_pyg.sh
│   └── run_notebook.sh
├── requirements.txt
├── environment.yml
├── .gitattributes
├── .gitignore
├── LICENSE
└── README.md
```

## Setup

### A) Conda (CPU baseline)
```bash
conda env create -f environment.yml
conda activate fusion-wsn
pip install --index-url https://download.pytorch.org/whl/cpu torch==2.2.2 torchvision==0.17.2
pip install pyg-lib torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric \
  -f https://data.pyg.org/whl/torch-2.2.2+cpu.html
pip install -r requirements.txt
```

### B) Pip + GPU (CUDA 12.1, e.g., Colab Pro L4)
```bash
pip install --index-url https://download.pytorch.org/whl/cu121 torch==2.2.2 torchvision==0.17.2
pip install pyg-lib torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric \
  -f https://data.pyg.org/whl/torch-2.2.2+cu121.html
pip install -r requirements.txt
```

## Data
- Use the **four public datasets** referenced in the paper; download them into `data/raw/` (subfolders per dataset).
- The notebook harmonizes schemas, aligns UTC timestamps, performs leakage-safe splits, builds the directed cosine kNN graph, computes trust (R,C,H,T), trains GATv2, calibrates the threshold, and exports figures/tables.
- Large files should **not** be committed. If you publish processed artifacts or models, use Git LFS and the `release` branch (see below).

## Reproduce
Open the notebook and **Run All**. For headless mode:
```bash
pip install papermill jupyter
bash scripts/run_notebook.sh
```

Outputs (metrics, calibrated threshold, confusion matrices, ROC/PR, calibration plots) are saved under `outputs/`.

## Branching
- `main`: code + notebook only (no large files).
- `release`: optional branch with `data/processed/` and `models/` tracked via **Git LFS** for quick evaluation.

## Notes
- Preprocessing/graph/trust on **CPU**, GNN training on **GPU** (L4) for best energy/runtime trade-off.
- Seeds fixed; standardization fit on **training** only and reused elsewhere; graph uses `k=16` (ECO=`8`); threshold calibrated on validation and frozen.
