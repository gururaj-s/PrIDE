#!/bin/tcsh

# change runscript.sh
#s/DDR4_2400_16x4 ==> DDR5_2400_32x4 --> DRAMInterface.py (modify and half tREFI and banks_per_rank=32)

# Run Baseline 
#run_baseline_experiments.sh 1 <--- done


# Run RFM Experiments
set qsub = 0
set RFM  = 0

#mitig 1 br 1 <-- done
#mitig 2 br 1 <-- done
#mitig 4 br 1 <-- done
#mitig 8 br 1 <-- done

#./run_rfm_experiments.sh 1 1 0 0 <-- done
#./run_rfm_experiments.sh 2 1 0 0 <-- done
#./run_rfm_experiments.sh 4 1 0 0 <-- done
#./run_rfm_experiments.sh 8 1 0 0 <-- done


#./run_rfm_experiments.sh 1 2 0 0 <-- done
#./run_rfm_experiments.sh 2 2 0 0 #<-- done
#./run_rfm_experiments.sh 4 2 0 0 #<-- done
#./run_rfm_experiments.sh 8 2 0 0 #<-- done

#./run_rfm_experiments.sh 1 4 0 0 <-- done
#./run_rfm_experiments.sh 2 4 0 0 <-- done
#./run_rfm_experiments.sh 4 4 0 0 <-- done
#./run_rfm_experiments.sh 8 4 0 0 <-- done

mitig 2 br 2 <-- done
mitig 4 br 2 <-- done
mitig 8 br 2 <-- done

mitig 1 br 4 <-- done
mitig 2 br 4 <-- done
mitig 4 br 4 <-- done
mitig 8 br 4 <-- done

foreach num_mitig ( 1 2 4 8 ) #1 2 4 8)
  foreach br (1 2 4)
    echo "./run_rfm_experiments.sh $num_mitig $br $RFM $qsub"
  end
end



