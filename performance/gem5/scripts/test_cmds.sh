#!/bin/bash

#### LOAD ENV
#source /home/gsaileshwar/rowhammer_defense/spec2017/env.lsf.sh
#echo "--- Done --- "

### TEST PYTHON 
#gcc -v 
#ldd --version
#../build/X86/gem5.opt

## Checkpoint
#!/bin/bash
echo 'Running command: /home/gsaileshwar/rowhammer_defense/aqua_gem5/gem5/scripts/ckptscript_test.sh perlbench 4 2017'
/home/gsaileshwar/rowhammer_defense/aqua_gem5/gem5/scripts/ckptscript_test.sh perlbench 4 2017

## Run 
echo 'Running runscript'
/home/gsaileshwar/rowhammer_defense/aqua_gem5/gem5/scripts/runscript_test.sh perlbench test4 4 2017
