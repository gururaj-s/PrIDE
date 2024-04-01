cd ..
mkdir -p stats_scripts/data 

## Normalized Performance based on Weighted-Speedup Metric ###
## Inverted for Slowdown ##

for i in system.mem_ctrls.dram.rank0.actEnergy system.mem_ctrls.dram.rank0.preEnergy system.mem_ctrls.dram.rank0.readEnergy system.mem_ctrls.dram.rank0.writeEnergy system.mem_ctrls.dram.rank0.refreshEnergy system.mem_ctrls.dram.rank0.actBackEnergy system.mem_ctrls.dram.rank0.preBackEnergy system.mem_ctrls.dram.rank0.totalEnergy system.mem_ctrls.dram.rank0.averagePower sim_seconds system.mem_ctrls.rh_rrs_num_accesses system.mem_ctrls.rh_num_rfms ; do
echo "##########"
echo "$i"
echo ""

perl getdata.pl -w spec17_all_press -noxxxx -s $i      -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM1.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM2.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM5.BR2.4C  

done
