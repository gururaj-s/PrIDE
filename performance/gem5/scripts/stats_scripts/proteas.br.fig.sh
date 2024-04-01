cd ..
mkdir -p stats_scripts/data 

echo "TRH=5000, TRH=2000, TRH=1000, TRH=500:"
echo ""
echo "RTH Blast-Radius=1 Blast-Radius=2 Blast-Radius=4"  > stats_scripts/data/press_br.stat

# GMEAN All 34
perl getdata.pl -n 0 -nh -ns -gmean -w spec17_rate_press  -ipc 4 -ws -printmask 0-1-1-1-1 -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM1.BR1.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM1.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM1.BR4.4C \
    | sed 's/Gmean/TRH=5000/' | column -t >> stats_scripts/data/press_br.stat;

perl getdata.pl -n 0 -nh -ns -gmean -w spec17_rate_press  -ipc 4 -ws -printmask 0-1-1-1-1 -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM2.BR1.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM2.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM2.BR4.4C \
    | sed 's/Gmean/TRH=2000/' | column -t >> stats_scripts/data/press_br.stat;

perl getdata.pl -n 0 -nh -ns -gmean -w spec17_rate_press  -ipc 4 -ws -printmask 0-1-1-1-1 -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM4.BR1.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM4.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM4.BR4.4C \
    | sed 's/Gmean/TRH=1000/' | column -t >> stats_scripts/data/press_br.stat;

perl getdata.pl -n 0 -nh -ns -gmean -w spec17_rate_press  -ipc 4 -ws -printmask 0-1-1-1-1 -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
     -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM8.BR1.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM8.BR2.4C \
     ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/RFM8.BR4.4C \
    | sed 's/Gmean/TRH=500/' | column -t >> stats_scripts/data/press_br.stat;

cat stats_scripts/data/press_br.stat ; 
