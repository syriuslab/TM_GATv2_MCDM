#!/usr/bin/env bash
set -e
OUTDIR=outputs
NB=notebooks/TrustGNN_Fused_Pipeline_RIG.ipynb
mkdir -p ${OUTDIR}
papermill "${NB}" "${OUTDIR}/run_$(date +%Y%m%d_%H%M%S).ipynb"
echo "Done. Outputs saved to ${OUTDIR}/"
