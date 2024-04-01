#!/bin/bash

######----------------------------------------------------- ######
######------------- RUN FOR 4/1-CORE EXPERIMENTS ---------- ######
######----------------------------------------------------- ######

rfm=$1
br=$2
rfm0_or_para1=$3
qsub=$4

# Check if $qsub is empty
if [ -z "$qsub" ] 
then
    qsub=0
fi
# Setting default vals for rfm and br
if [ -z "$rfm" ] 
then
    rfm=1
fi
if [ -z "$br" ] 
then
    br=1
fi
if [ -z "$rfm0_or_para1" ] 
then
    rmf0_or_para1=0
fi
defense_name=RFM
if [ $rfm0_or_para1 -eq 1 ] 
then
    defense_name=PARA
fi

if [ $qsub -gt 0 ] 
then
    qsub=1
    qsub_cmdfile="run_cmds.txt"
    rm -rf $qsub_cmdfile ; touch $qsub_cmdfile ;
fi

config="${defense_name}${rfm}.BR${br}.4C"

##  gcc bwaves mcf cactuBSSN namd povray lbm wrf\
##  x264 blender deepsjeng imagick leela nab exchange2 roms xz parest\
##  mix1 mix2 mix3 mix4 mix5 mix6 mix7 mix8 mix9 mix10\
##  mix11 mix12 mix13 mix14 mix15 mix16\
for bmk in perlbench\
; do 
    #************* RRS base config BEGIN *************#
    # 
    if [ $qsub -gt 0 ] 
    then
	echo "./runscript_test.sh $bmk $config 4 2017 --rh_defense --rh_mitigation=${defense_name} --rh_rfm_per_trefi=${rfm} --rh_rfm_blast_radius=${br} --rh_rfm_maxacts_per_trefi=166" >> $qsub_cmdfile;
    else    	    
    ./runscript_test.sh $bmk $config 4 2017 \
     --rh_defense --rh_mitigation=${defense_name} --rh_rfm_per_trefi=${rfm} --rh_rfm_blast_radius=${br} --rh_rfm_maxacts_per_trefi=166 ;
    fi
    #************* RRS base config END *************#

##     #************* RRS scalability configs BEGIN *************#
##     # RRS for TRH=2K
##     ./runscript.sh $bmk AE.RRS.2K.4C 4 2017 \
##      --rh_defense --rh_mitigation=RRS --rh_actual_threshold=2000;
##     # RRS for TRH=4K
##     ./runscript.sh $bmk AE.RRS.4K.4C 4 2017 \
##      --rh_defense --rh_mitigation=RRS --rh_actual_threshold=4000;
##     #************* RRS scalability configs END *************#

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
