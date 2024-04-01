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

  for bmk in perlbench gcc bwaves mcf cactuBSSN namd povray lbm wrf \
      x264 blender deepsjeng imagick leela nab exchange2 roms xz parest \
      mix1 mix2 mix3 mix4 mix5 mix6 mix7 mix8 mix9 mix10 \
      mix11 mix12 mix13 mix14 mix15 mix16 mix17 ; do 
# for bmk in mix2 mix17 ; do
    #************* AQUA SRAM config BEGIN *************#
    # AQUA with SRAM tables for TRH=1K
    if [ $qsub -gt 0 ] 
    then
	echo "./runscript.sh $bmk AE.AQUA.SRAM_TABLES.1K.4C 4 2017 --rh_defense --rh_mitigation=RQ --rh_actual_threshold=1000 --rh_rq_disable_rit_virt --rh_rq_cache_sets=256 --rh_rq_rows_per_btv_bit=16 --rh_rq_qr_size=23053 " >> $qsub_cmdfile;
    else
	./runscript.sh $bmk AE.AQUA.SRAM_TABLES.1K.4C 4 2017 \
	    --rh_defense --rh_mitigation=RQ --rh_actual_threshold=1000 \
	    --rh_rq_disable_rit_virt --rh_rq_cache_sets=256 --rh_rq_rows_per_btv_bit=16 \
	    --rh_rq_qr_size=23053;
    fi
    #************* AQUA SRAM config END *************#

##    #************* AQUA Memory-Mapped config END *************#
##    # AQUA with Memory-Mapped tables for TRH=1K
##    ./runscript.sh $bmk AE.AQUA.MEMORY_MAPPED_TABLES.1K.4C 4 2017 \
##     --rh_defense --rh_mitigation=RQ --rh_actual_threshold=1000 \
##     --rh_rq_cache_sets=256 --rh_rq_rows_per_btv_bit=16 \
##     --rh_rq_qr_size=23053;
##    #************* AQUA Memory-Mapped config END *************#
##
##    #************* AQUA scalability configs BEGIN *************#
##    # AQUA with Memory-Mapped tables for TRH=2K
##    ./runscript.sh $bmk AE.AQUA.MEMORY_MAPPED_TABLES.2K.4C 4 2017 \
##     --rh_defense --rh_mitigation=RQ --rh_actual_threshold=2000 \
##     --rh_rq_cache_sets=256 --rh_rq_rows_per_btv_bit=16 \
##     --rh_rq_qr_size=15302;
##
##    # AQUA with Memory-Mapped tables for TRH=500
##    ./runscript.sh $bmk AE.AQUA.MEMORY_MAPPED_TABLES.500.4C 4 2017 \
##     --rh_defense --rh_mitigation=RQ --rh_actual_threshold=500 \
##     --rh_rq_cache_sets=256 --rh_rq_rows_per_btv_bit=16 \
##     --rh_rq_qr_size=30872;
##    #************* AQUA scalability configs END *************#

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
