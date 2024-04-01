# PrIDE

Overview:
=========

This repository provides the artifacts to reproduce the data in our
ISCA paper titled "PrIDE: Achieving Secure Rowhammer Mitigation with
Low-Cost In-DRAM Trackers".

The artifacts provided are C++ source files that are organized in two
sub directories: security and performance. The performance directory
includes the gem5 infrastructure that we used for performance
modeling. The security directory includes two additional
subdirectories.

a) The "loss_probability" directory provides artifacts for estimating
  the worst case loss probability of an arbitrary sized Tracker. We
  provide artifacts for estimating loss probability analytically and
  also provide artifact for validating the analytical bounds using
  monte-carlo simulations. The monte-carlo simulations (which are
  somewhat long running) also include a model for our proposed tracker
  design. The output of this artifact can be used to validating the
  "Loss Prob (L)" column reported in Table III.

b) The "reliability" directory provides artifacts that provide the
   primary contributions of the paper: reliability of PrIDE. The
   artifact provides the source code for replicating data reported in
   Figure 9, and tables VI, VIII, and IX.


Instructions:
=============

a) Verifying the security models: change into the 'security' directory
   and run the script 'run_security_analysis.sh'. This script will
   first change into loss_probability directory to collect the loss
   probabilities for the tracker. Note that this process will take
   about X minutes to run. The script will print the loss probability
   for the Tracker sizes reported in Table III.

   The script will then automatically change into the reliability
   directory. It will compile the reliabiility model print out in text
   form the data reported in Figure 9, and tables VI, VIII, and IX.
