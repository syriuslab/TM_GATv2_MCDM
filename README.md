# Fusion-WSN Graph Trust Framework

This repository contains the code and experiments for the paper **Trust-Aware Graph Learning for IoT/WSN**. It mirrors the simple, notebook-driven layout of the `syriuslab/fusion_framework` project while adapting it to a graph + trust pipeline.

## Branches
- `main`: lightweight, code-only branch. Run all notebooks to reproduce results (datasets required).
- `release`: includes processed artifacts (`data/processed/`) and trained models (`models/`) via **Git LFS** for quick evaluation.

## Structure
```
.
├── data/
│   ├── raw/         # download public datasets here
│   └── processed/   # generated artifacts (splits, standardized arrays, graphs)
├── models/          # trained checkpoints (GNN, scalers)
├── notebooks/
│   ├── 01_data_harmonization.ipynb
│   ├── 02_graph_and_trust_build.ipynb
│   ├── 03_gnn_training_and_evaluation.ipynb
│   └── 04_results_figures_and_tables.ipynb
├── requirements.txt
├── .gitattributes   # LFS patterns (release branch)
├── .gitignore
└── README.md
```

## Setup
```bash
python -m venv .venv && source .venv/bin/activate  # or conda
pip install -r requirements.txt
# If PyG wheel fails, install matching wheel from https://data.pyg.org/whl/
```

## Datasets
Use four public IoT/WSN datasets as in the paper. Place raw files under `data/raw/<dataset_name>/`. The notebooks harmonize schemas, align UTC timestamps, perform leakage-safe splits, and build directed cosine kNN graphs.

## Running
Run notebooks in order:
1. **01_data_harmonization.ipynb** — unify schemas, standardize features.
2. **02_graph_and_trust_build.ipynb** — construct kNN graph; compute R, C, H, T.
3. **03_gnn_training_and_evaluation.ipynb** — train GATv2; calibrate threshold (Eq. 7); export metrics/plots.
4. **04_results_figures_and_tables.ipynb** — generate publication figures and tables.

> GPU (e.g., NVIDIA L4) is recommended only for step 3; steps 1–2 run on CPU for energy efficiency.
