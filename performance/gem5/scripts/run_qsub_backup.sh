#!/bin/tcsh
# real_queue names:  o_short , o_medium, o_long
# list_queues -P real_queue=o_short -o run_limit -o mem_limit
set PROJECT = research_arch_misc
set CPUS    = 1
set QUEUE   = o_cpu_32G_15M # o_cpu_16G_24H   #o_cpu_16G_24H
foreach i (`cat $1`)
  qsub -P $PROJECT -n $CPUS -q $QUEUE -oo $i:r.lsf.out $i
end
mv $1 $1.done
