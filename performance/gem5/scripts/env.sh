#!/bin/bash

#Paths for Gem5 & SPEC
# Must change these paths

export GEM5_PATH=/home/scratch.ajaleel_nvresearch/rowhammer/gururaj/rowhammer_defense/aqua_gem5/gem5
export SPEC17_PATH=/home/scratch.ajaleel_nvresearch/rowhammer/gururaj/rowhammer_defense/spec2017/spec-cpu-2017-main
export CKPT_PATH=/home/scratch.ajaleel_nvresearch/rowhammer/gururaj/rowhammer_defense/aqua_gem5/cpts

# Optional: change as per maximum number of parallel gem5 runs the system can handle
export MAX_GEM5_PARALLEL_RUNS=22

