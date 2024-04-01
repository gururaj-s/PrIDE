#!/bin/bash

######----------------------------------------------------- ######
######------------- RUN FOR 4/1-CORE EXPERIMENTS ---------- ######
######----------------------------------------------------- ######

qsub=$1
# Check if $qsub is empty
if [ -z "$qsub" ] 
then
    qsub=0
fi

if [ $qsub -gt 0 ] 
then
    qsub=1
    qsub_cmdfile="run_cmds.txt"
    rm -rf $qsub_cmdfile ; touch $qsub_cmdfile ;
fi


 # baseline single-core SPEC17 workloads
 for bmk in perlbench gcc bwaves mcf cactuBSSN namd povray lbm wrf\
   blender deepsjeng imagick leela nab exchange2 roms xz parest; do 
    if [ $qsub -gt 0 ] 
    then
	echo "./runscript.sh $bmk AE.BASELINE.1C 1 2017" >> $qsub_cmdfile;
    else
     ./runscript.sh $bmk AE.BASELINE.1C 1 2017; 
    fi
 done
 
# baseline multi-core SPEC17 workloads
 ## for bmk in mix2 mix17 \
for bmk in \
    perlbench gcc bwaves mcf cactuBSSN namd povray lbm wrf \
    blender deepsjeng imagick leela nab exchange2 roms xz parest \
    mix1 mix2 mix3 mix4 mix5 mix6 mix7 mix8 mix9 mix10 \
  mix11 mix12 mix13 mix14 mix15 mix16 mix17 \
    ; do 
    if [ $qsub -gt 0 ] 
    then
	echo "./runscript.sh $bmk AE.BASELINE.4C 4 2017" >> $qsub_cmdfile;
    else 
	./runscript.sh $bmk AE.BASELINE.4C 4 2017; 
    fi
    ## Wait for a core to be available
    exp_count=`ps aux | grep -i "gem5" | grep -v "grep" | wc -l`
    if [ -z "$qsub" ] 
    then
	while [ $exp_count -gt ${MAX_GEM5_PARALLEL_RUNS} ]
	do
            sleep 300
            exp_count=`ps aux | grep -i "gem5" | grep -v "grep" | wc -l`
            echo
	done
    fi
done

exp_count=`ps aux | grep -i "gem5" | grep -v "grep" | wc -l`
if [ -z "$qsub" ] 
then
    while [ $exp_count -gt 0 ]
    do
	sleep 300
	exp_count=`ps aux | grep -i "gem5" | grep -v "grep" | wc -l`    
    done
fi


if [ $qsub -gt 0 ]
then 
    echo "Sending jobs to farm"
    ./run_qsub.sh $qsub_cmdfile ;
    echo "Done sending jobs to farm"
fi
