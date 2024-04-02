## PrIDE: Achieving Secure Rowhammer Mitigation with Low-Cost In-DRAM Trackers

Authors: Aamer Jaleel, Gururaj Saileshwar, Steve Keckler, and Moinuddin K. Qureshi

To appear in [ISCA 2024](https://iscaconf.org/isca2024/)

### Overview:

This repository provides the artifacts to reproduce the data in our ISCA paper titled "PrIDE: Achieving Secure Rowhammer Mitigation with Low-Cost In-DRAM Trackers".

The artifacts provided are C++ source files that are organized in two sub directories: *security* and *performance*. 

* `security` directory includes the code and scripts to reproduce our key results of PrIDE.
  *  `0_loss_probability` folder provides the loss-probability evaluation (Table-III, Figure 8) for an arbitrary sized tracker (analytically and using monte-carlo simulations) 
  * `1_reliability` folder provides our time-to-failure and TRH calculations (Figure 9, and Tables VI, VIII, and IX)

* `performance` directory:  includes the gem5 infrastructure that we used for performance
  modeling of PrIDE. 

### Requirements For Security Evaluations:
   - **SW Dependencies:** gcc, Python-3
   - **HW Dependencies:** x86 system with single core
   - **Expected Time:** Less than 10 mins. The Monte-Carlo simulations to estimate probabilities take the longest and require a few minutes (~5 mins).

### Requirements For Performance Evaluations in Gem5 CPU Simulator:
   - **SW Dependencies:** Gem5 Dependencies - gcc, Python-3.6.3, scons-3.
     - Tested with gcc v9 and scons-3.0.5
     - Scons-3.0.5 download [link](https://sourceforge.net/projects/scons/files/scons/3.0.5/scons-3.0.5.tar.gz/download). To install, `tar -zxvf scons-3.0.5.tar.gz` and `cd scons-3.0.5; python setup.py install` (use `--prefix=<PATH>` for local install).
   - **Benchmark Dependencies:** [SPEC-2017](https://www.spec.org/cpu2017/) Installed.
   - **HW Dependencies:** 
     - A 22 core system to finish experiments in ~3 days (majority of the time is required to generate the checkpoints for benchmarks - 1-2 days).

### Instructions to Reproduce Results:

#### Clone the Repo

* Use the following command: ```git clone https://github.com/gururaj-s/PrIDE.git```

#### Reproduce Security Results

**Key Results:** Figure 8, Figure 9, Table-III, Tables VI, VIII, and IX.

**Code to Execute:**

```bash
cd security                    # Change into the `security` directory
./run_security_analysis.sh     # Run the script `run_security_analysis.sh`
```

**Steps Executed:**

* This script will automatically first change into `0_loss_probability` directory to collect the loss probabilities for the tracker of different sizes (Table-III). Note that this process will take less than 10 minutes to run. The output is saved  in `0_loss_probability/analytical/output`.
* Subsequently, it runs the python script `0_loss_probability/analytical/loss_1entry.py` to generate the *loss probability* vs *position of attacked row* (Figure 8) and will save the plot in `0_loss_probability/analytical/output`.
* Then the script will change into the `1_reliability` directory, compile the reliabiility model, and print the data in Figure 9, and Tables VI, VIII, IX.

#### Reproduce Performance Results on Gem5

**Key Result:** Figure 14

**Steps to Execute:**

1. **Compile Gem5:** `cd gem5 ; scons -j50 build/X86/gem5.opt`
2. **Compile & Run SPEC CPU 2017 Benchmarks:** If you already do not have a working SPEC-CPU-2017 installation, please follow the  [README_SPEC17_INSTALLATION.md](./performance/README_SPEC_INSTALLATION.md)  that has steps to install the SPEC-17 binaries (note that this may take an additional 1-2 days to set up and test).
3. **Set Paths** in `scripts/env.sh`. You will set the following :
    - `GEM5_PATH`: the full path of the gem5 directory (that is, `<current-dirctory>/gem5`).
    - `SPEC17_PATH`: the path to your SPECint-CPU 2017 installation. 
    - `CKPT_PATH`: the path to a new folder where the checkpoints will be created next (for example, `<current-directory/cpts>`).
    - Please source the paths as: `source scripts/env.sh` after modifying the file.
4. **Test Creating and Running Checkpoints:** For each program the we need to create a checkpoint of the program state after the initialization phase of the program is complete, which will be used to run the simulations with PrIDE. 
    - To test the checkpointing process, run `cd scripts; ./ckptscript_test.sh perlbench 4 2017;`: this will create a checkpoint after 1Mn instructions (should complete in a couple of minutes).
      * In case the `ckptscript_test.sh` fails with the error `$SPEC17_PATH/SPEC2017_inst/benchspec/CPU/500.perlbench_r/run/run_base_refrate_<config-name>-m64.<run-number>/perlbench_r_base.<config-name>-m64: No such file or directory` (or similar error message), it indicates the script is unable to find the run-directory for perlbench. Please follow the steps outlined in [README_SPEC17_INSTALLATION.md](./performance/README_SPEC_INSTALLATION.md) to ensure the run-directories are properly set up for all the SPEC-benchmarks.
5. **Run All Experiments**: We will provide these instructions shortly.
6. **Parse the Results:** We will provide these instructions shortly.
