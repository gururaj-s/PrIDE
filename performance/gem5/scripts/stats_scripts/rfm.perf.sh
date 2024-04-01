cd ..
mkdir -p stats_scripts/data 

## Normalized Performance based on Weighted-Speedup Metric ###
## Inverted for Slowdown ##

echo "TRH=1000 BR-2"
echo ""
perl getdata.pl -n 0 -gmean -w spec17_all_press  -ipc 4 -ws -printmask 0-1-1 -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM4.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA16.BR2.4C 

echo ""
echo "TRH=2000, 1000, 500 BR-2"
echo ""
perl getdata.pl  -n 0 -ns -gmean -w spec17_all_press  -ipc 4 -ws -printmask 0-1-1-1-1-1-1 -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM1.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA5.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM4.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA16.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM8.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA45.BR2.4C 

echo ""
echo "TRH=1000 BR-1,BR-2,BR-4"
echo ""
perl getdata.pl  -n 0 -ns -gmean -w spec17_all_press  -ipc 4 -ws -printmask 0-1-1-1-1-1-1 -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM4.BR1.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA16.BR1.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM4.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA16.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM4.BR4.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA16.BR4.4C 

echo ""
echo "TRH=500 BR-1,BR-2,BR-4"
echo ""
perl getdata.pl  -n 0 -ns -gmean -w spec17_all_press  -ipc 4 -ws -printmask 0-1-1-1-1-1-1 -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM8.BR1.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA45.BR1.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM8.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA45.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM8.BR4.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/PARA45.BR4.4C 

## 
## # 18 SPEC workloads
## perl getdata.pl -n 0  -w spec17_single -ipc 4 -ws -printmask 0-1-1-1  \
##     -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
##     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
##     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.RRS.4K.4C \
##     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.RRS.2K.4C \
##     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.RRS.1K.4C \
##     | sed 's/[_A-Z0-9]*[\/]*AE.RRS.4K.4C/4K/' | sed  's/[_A-Z0-9]*[\/]*AE.RRS.2K.4C/2K/' | sed  's/[_A-Z0-9]*[\/]*AE.RRS.1K.4C/1K/' \
##     | sed 's/[_A-Z]*\///' | column -t > stats_scripts/data/rrs_scalability.stat ; 
## 
## # # MIX-16 workloads
## perl getdata.pl -n 0 -nh  -w spec17_mix -ipc 4 -ws -printmask 0-1-1-1  -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
##     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
##     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.RRS.4K.4C \
##     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.RRS.2K.4C \
##     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.RRS.1K.4C \
##     | sed 's/[_A-Z]*\///' | column -t  >> stats_scripts/data/rrs_scalability.stat ; 
## 
## echo ".  0  0  0" | column -t >> stats_scripts/data/rrs_scalability.stat ; 
## 
## # Avg - ALL-34
## perl getdata.pl -gmean -n 0 -nh -ns -gmean -w spec17_all  -ipc 4 -ws -printmask 0-1-1-1  -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
##     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
##     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.RRS.4K.4C \
##     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.RRS.2K.4C \
##     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.RRS.1K.4C \
##     | sed 's/Gmean/Gmean-34/' | column -t >> stats_scripts/data/rrs_scalability.stat;
## 
## # Rename mixes:
## 
## # Format
## cat stats_scripts/data/rrs_scalability.stat
