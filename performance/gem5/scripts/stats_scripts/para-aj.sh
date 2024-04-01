cd ..
mkdir -p stats_scripts/data 

## Normalized Performance based on Weighted-Speedup Metric ###
## Inverted for Slowdown ##

 echo "PARA Perf, TRH=5000, 1000, 500"
 echo ""
 perl getdata.pl -n 0 -gmean -w spec17_all_press  -ipc 4 -ws -printmask 0-1-1-1-1-1-1-1 -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
     -d  ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
         ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA3.BR2.4C \
         ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA4.BR2.4C \
         ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA5.BR2.4C \
         ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM1.BR2.4C \
         ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM2.BR2.4C \
         ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM4.BR2.4C \
         ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM8.BR2.4C 

# echo ""
# echo "PARA Extra ACTs and DRAM ACC , TRH=5000, 1000, 500"
# echo ""
## for i in rh_num_rfms dram.num_reads::total dram.num_writes::total ; do
##     echo " STAT: $i ";
##     echo "" ; 
##     perl getdata.pl -amean -w spec17_all_press -noxxxx -s $i  \
##          -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA5.BR2.4C \
##          ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA16.BR2.4C \
##          ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA45.BR2.4C 
## done

#echo ""
#echo "PARA Ratio of Extra ACTs, TRH=5000, 1000, 500"
#echo ""
#perl getdata.pl -amean -ns -w spec17_all_press -noxxxx -cstat rfm4_dramAcc \
#         -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA4.BR2.4C \
#         ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA16.BR2.4C \
#         ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA33.BR2.4C 
