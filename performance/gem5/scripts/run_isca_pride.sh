#!/bin/tcsh

set PARA = 0  # use RFMs
set QSUB = 0

## Create Checkpoints
./create_checkpoints.sh

## Run Baseline
./run_pride_baseline_experiments.sh

## Run PrIDE (all configurations).
foreach num_mitig ( 1 2 5 )
  foreach br (1)
    ./run_pride_experiments.sh $num_mitig $br $PARA $QSUB
  end
end
