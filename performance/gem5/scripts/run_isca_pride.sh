#!/bin/bash

PARA=0  # use RFMs
QSUB=0

## Create Checkpoints
./create_checkpoints.sh

## Run Baseline
./run_pride_baseline_experiments.sh

## Run PrIDE (all configurations).
for num_mitig in 1 2 5; do
    for br in 1; do
      ./run_pride_experiments.sh "$num_mitig" "$br" "$PARA" "$QSUB";
    done
done
