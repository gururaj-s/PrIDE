#!/bin/bash

######----------------------------------------------------- ######
######------------- CHECKPOINTS FOR 4/1-CORE EXPERIMENTS -- ######
######----------------------------------------------------- ######

## Set the paths
source env.sh;


## Eror Checking
if [ -z ${MAX_GEM5_PARALLEL_RUNS+x} ];
then
    echo "MAX_GEM5_PARALLEL_RUNS is unset";
    exit
else
    echo "MAX_GEM5_PARALLEL_RUNS is set to '$MAX_GEM5_PARALLEL_RUNS'";
fi

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

# We left out cam4, xalancbmk, fotonik3d, omnetpp, and x264
###### 1-Core SPEC2017 Experiments #######
echo "Creating 1-Core Checkpoints for 18 Benchmarks"
for bmk in perlbench gcc bwaves mcf cactuBSSN namd povray lbm wrf\
  blender deepsjeng imagick leela nab exchange2 roms xz parest; do 
    if [ $qsub -gt 0 ] 
    then
	echo "./ckptscript.sh $bmk 1 2017" >> $qsub_cmdfile; 
    else	
	./ckptscript.sh $bmk 1 2017; 
    fi
    # Wait for a core to be available
    exp_count=`ps aux | grep -i "gem5" | grep -v "grep" | wc -l`
    if [ -z "$qsub" ] 
    then
	while [ $exp_count -gt ${MAX_GEM5_PARALLEL_RUNS} ]
	do
            sleep 300
            exp_count=`ps aux | grep -i "gem5" | grep -v "grep" | wc -l`
	    echo "$exp_count"
	done
    fi
done
 
# ####### 4-Core SPEC2017 Experiments #######
echo "Creating 4-Core Checkpoints for 34 Benchmarks"
 for bmk in perlbench gcc bwaves mcf cactuBSSN namd povray lbm wrf\
  blender deepsjeng imagick leela nab exchange2 roms xz parest\
  mix1 mix2 mix3 mix4 mix5 mix6 mix7 mix8 mix9 mix10\
  mix11 mix12 mix13 mix14 mix15 mix16; do 
    if [ $qsub -gt 0 ] 
    then    
	echo "./ckptscript.sh $bmk 4 2017" >> $qsub_cmdfile
    else
	./ckptscript.sh $bmk 4 2017 ;
    fi
    # Wait for a core to be available
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

wait 

if [ $qsub -gt 0 ]
then 
    echo "Sending jobs to farm"
    ./run_qsub.sh $qsub_cmdfile ;
    echo "Done sending jobs to farm"
fi
