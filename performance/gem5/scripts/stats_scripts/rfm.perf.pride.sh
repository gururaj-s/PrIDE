cd ..
mkdir -p stats_scripts/data 

## Normalized Performance based on Weighted-Speedup Metric ###
## Inverted for Slowdown ##

perl getdata.pl -n 0 -gmean -w spec17_all_press  -ipc 4 -ws -printmask 0-1-1-1-1 -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/pride_multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/pride_multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM1.BR1.4C \
     ../stats/pride_multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM2.BR1.4C \
     ../stats/pride_multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM5.BR1.4C

