## PrIDE: Achieving Secure Rowhammer Mitigation with Low-Cost In-DRAM Trackers

Authors: Aamer Jaleel, Gururaj Saileshwar, Steve Keckler, and Moinuddin K. Qureshi

To appear in [ISCA 2024](https://iscaconf.org/isca2024/)

### Overview:

This repository provides the artifacts to reproduce the data in our ISCA paper titled "PrIDE: Achieving Secure Rowhammer Mitigation with Low-Cost In-DRAM Trackers".

The artifacts provided are C++ source files that are organized in two sub directories: *security* and *performance*. 

* `security` directory includes the code and scripts to reproduce our key results of PrIDE.
  *  `0_loss_probability` folder provides the loss-probability evaluation (Table-III, Figure 8) for an arbitrary sized tracker (analytically and using monte-carlo simulations) 
  * `1_reliability` folder provides our time-to-failure and TRH calculations (Figure 9, Tables VI, VIII, and IX)

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

### Reproduce Security Results

**Key Results:** Figure 8, Figure 9, Table-III, Tables VI, VIII, and IX.

**Code to Execute:**

```bash
git clone https://github.com/gururaj-s/PrIDE.git   # Clone the repo
cd security                                        # Change into the `security` directory
./run_security_analysis.sh                         # Run `run_security_analysis.sh`
```

**Steps Executed:**

* This script will automatically first change into `0_loss_probability` directory to collect the loss probabilities for the tracker of different sizes (Table-III). Note that this process will take less than 10 minutes to run. The output is saved  in `0_loss_probability/analytical/output`.
* Subsequently, it runs the python script `0_loss_probability/analytical/loss_1entry.py` to generate the *loss probability* vs *position of attacked row* (Figure 8) and will save the plot in `0_loss_probability/analytical/output`.
* Then the script will change into the `1_reliability` directory, compile the reliabiility model, and print the data in Figure 9, and Tables VI, VIII, IX.

### Reproduce Performance Results on Gem5

**Key Result:** Figure 14

**Steps to Execute:**

1. **Compile Gem5:** `cd performance/gem5 ; scons -j50 build/X86/gem5.opt`

2. **Compile & Run SPEC CPU 2017 Benchmarks:** If you already do not have a working SPEC-CPU-2017 installation, please follow the  [README_SPEC17_INSTALLATION.md](./performance/README_SPEC_INSTALLATION.md)  that has steps to install the SPEC-17 binaries (note that this may take an additional 1-2 days to set up and test).

    * If you are using an existing SPEC-17 installation, please follow the steps to set the prefix/suffix as per your SPEC17 binaries in `performance/gem5/configs/example/spec17_benchmarks.py` as described in [README_SPEC17_INSTALLATION.md](./performance/README_SPEC_INSTALLATION.md). 

3. **Set Paths** in `scripts/env.sh` in the `gem5` folder. You will set the following :

    - `GEM5_PATH`: the full path of the gem5 directory (that is, `<REPO HOME>/performance/gem5`).
    - `SPEC17_PATH`: the path to your SPECint-CPU 2017 installation. 
    - `CKPT_PATH`: the path to a new folder where the checkpoints will be created next (for example, `<REPO HOME>/performance/gem5/cpts`).
    - Please source the paths as: `source scripts/env.sh` after modifying the file.

4. **Test Creating Checkpoints:** For each program we need to create a checkpoint of the program state after the initialization phase of the program is complete, which will be used to run the simulations with PrIDE. 

    - To test the checkpointing process, run `cd scripts; ./ckptscript_test.sh perlbench 4 2017;`: this will create a checkpoint after 1Mn instructions (should complete in a couple of minutes).
      * Check the folder `$CKPT_PATH/multiprogram_16GBmem_1Mn.SPEC17.C4/perlbench-1-ref-x86`. You should see a checkpoint created there successfully.
      * In case the `ckptscript_test.sh` fails with the error `${SPEC17_PATH}/SPEC2017_inst/benchspec/CPU/500.perlbench_r/run/run_base_refrate_<config-name>-m64.<run-number>/perlbench_r_base.<config-name>-m64: No such file or directory` (or similar error message), it indicates the script is unable to find the run-directory for perlbench. Please follow the steps outlined in [README_SPEC17_INSTALLATION.md](./performance/README_SPEC_INSTALLATION.md) to ensure the run-directories are properly set up for all the SPEC-benchmarks.

5. **Run All Experiments**: Please run the following commands.

    ```bash
    cd performance/gem5/scripts;
    ./run_isca_pride.sh;           # Runs the checkpointing, baseline, and PrIDE runs
    ```

    This runs the following scripts:

    - `./create_checkpoints.sh`  - This creates checkpoints for single-core and multi-core benchmarks.
      * **Create Checkpoint:** For each benchmark, the checkpoints will be created using `./ckptscript.sh <BENCHMARK> <NUM-CORES> <SPEC-VERSION>`. 
        - By default, `ckptscript.sh` is run for 52 programs in parallel (18 single-core SPEC workloads, 18 multi-core SPEC workloads, and 16 multi-core MIXED workloads). 
        - For each program, the execution is forwarded by 25 Billion Instructions (by when the initialization of the program should have completed) and then the architectural state (e.g. registers, memory) is checkpointed. Subsequently, when each PrIDE is simulated these checkpoints will be reloaded.
        - This process can take 24-36 hours for each benchmark. Hence, all the benchmarks are run in parallel by default.
        - Please see `configs/example/spec17_benchmarks.py` for list of benchmarks supported.
    - `./run_pride_<baseline_>experiments.sh` - These scripts run the baseline and PrIDE configurations for all 34 benchmarks.
      * **Run experiments**: Once all the checkpoints are created, the scripts will internally use `./runscript_pride.sh <BMARK> <CONFIG-NAME> <NUM-CORES> <SPEC-VERSION> <RH-DEFENSE-PARAMETERS>`, where our Rowhammer defense configuration (PrIDE) is simulated with different parameters for each benchmark. For Baseline, no `<RH-DEFENSE-PARAMETERS>` is passed.
        - The arguments for `runscript.sh` are as follows:
          -  `BMARK`: The benchmark to be simulated, like perlbench.
          -  `CONFIG-NAME`: Any string that will be used to identify this run, and the name for the results-folder of this run.
          -  `NUM-CORES`: Number of cores, 4 for multi-core runs and 1 for single-core baseline runs.
          -  `SPEC-VERSION`: Fixed to be 2017.
          -  `RH-DEFENSE-PARAMETERS`: `--rh_defense` enables the defense, `--rh_mitigation=RFM` enables PrIDE as the defense,  `--rh_rfm_per_trefi=1/2/5` specifies how many mitigations are issued per tREFI (1 implies the mitigation is at tREFI and no RFM is needed, 2 implies one mitigation each at and during tREFI, and so on. Excluding the parameter `--rh_defense` , causes the baseline configuration to be run.
        - Each configuration is simulated for 250Mn instructions. This takes 3-6 hours per benchmark, per configuration. Benchmarks are run in parallel for a total of up to `MAX_GEM5_PARALLEL_RUNS` (defined in `scripts.env.sh`) parallel Gem5 runs at a time. 

6. **Parse the Results:** Please run the following commands.

    ```bash
    cd performance/gem5/scripts/stats_scripts; # Directory with Stats Collection Scripts
    ./rfm.perf.pride.sh                        # Collect and Report Stats for Figure 14 
    ```

#### Helpful Debugging Notes:

* **Note on Simulation Time:** Running all experiments takes almost 3-4 days on a system with 22 cores. This can be sped up by increasing the `MAX_GEM5_PARALLEL_RUNS` . By default it is set to 22.
  * To reduce experiment runtime, you may reduce instr. count (`MAX_INSTS`) in `runscript.sh`to 100Mn.
  * The dominant simulation cost then is running the checkpointing process, which takes ~1.5 days,

* **Note on Simulation Crashes:** One reason could be an issue with the benchmarks. A limited number of processor cores or limited DRAM can also be incapable of running 22 Gem5 processes in parallel causing crashes.
  * To check the benchmarks, one can try to run the benchmarks natively (without Gem5).
  * If amount of cores or DRAM is the limitation, one can decrease the `MAX_GEM5_PARALLEL_RUNS`. This will however linearly increase the simulation time.
