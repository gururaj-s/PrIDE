#!/bin/tcsh

set PARA = 0  # RFM instead
set QSUB = 0

foreach num_mitig ( 1 2 5 ) #1 2 4 8)
  foreach br (1)
    ./run_pride_experiments.sh $num_mitig $br $PARA $QSUB
  end
end
