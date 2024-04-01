cd ..
mkdir -p stats_scripts/data 

echo "TRH=5000, TRH=2000, TRH=1000, TRH=500: BR-2"
echo ""
echo "RTH 5K 2K 1K 500"  > stats_scripts/data/press_perf.stat

# 17 SPEC + 17 MIX workloads
perl getdata.pl -n 0 -nh -w spec17_all_press  -ipc 4 -ws -printmask 0-1-1-1-1 -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM1.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM2.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM4.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM8.BR2.4C \
     | column -t >> stats_scripts/data/press_perf.stat;

echo ".  0  0  0 0" | column -t >> stats_scripts/data/press_perf.stat ; 

# GMEAN All 34
perl getdata.pl -n 0 -nh -ns -gmean -w spec17_rate_press  -ipc 4 -ws -printmask 0-1-1-1-1 -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM1.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM2.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM4.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM8.BR2.4C \
    | sed 's/Gmean/Gmean-34/' | column -t >> stats_scripts/data/press_perf.stat;

cat stats_scripts/data/press_perf.stat ; 
