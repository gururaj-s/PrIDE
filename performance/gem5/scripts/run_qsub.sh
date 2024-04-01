#!/bin/bash

# Defines
# real_queue names:  o_short , o_medium, o_long
# list_queues -P real_queue=o_short -o run_limit -o mem_limit

PROJECT=research_arch_misc
CPUS=1
#QUEUE=o_cpu_8G_7D 
QUEUE=o_cpu_8G_48H #o_cpu_32G_15M #o_pri_cpu_24G_15M o_cpu_16G_24H   #o_cpu_16G_24H
OPTIONS=" -m rel7x -app affinity"
 
# Check if the commands file is provided
if [ $# -eq 0 ]; then
  echo "Please provide the path to the commands file."
  exit 1
fi

# Read the commands file
commands_file=$1
 
# Check if the commands file exists
if [ ! -f "$commands_file" ]; then
  echo "Commands file not found: $commands_file"
  exit 1
fi

# Create a new folder inside qsub_cmds based on the number of existing folders
run_number=$(ls -d qsub_cmds/*/ 2>/dev/null | wc -l)
run_number=$((run_number + 1))
folder_name="${PWD}/qsub_cmds/run_${run_number}"

# Create the new folder
mkdir -p "$folder_name"
echo "Qsub outputs saved in: ${folder_name}"
echo " " 

# Read the commands from the file, create command_bash_script, and submit them to qsub
line_number=1
while IFS= read -r command; do
  # Skip empty lines or lines starting with '#'
  if [[ -z "$command" || "$command" == "#"* ]]; then
    continue
  fi

  # Create the command bash script inside the new folder
  command_bash_script_name="${line_number}_$(echo "$command" | sed 's/.*\/\([^/]*\)$/\1/' | tr ' ' '_')"
  command_bash_script="${folder_name}/${command_bash_script_name}.sh"
  echo "#!/bin/bash" > $command_bash_script
  echo "echo 'Running command: $command'" >> "$command_bash_script"
  echo "$command" >> "$command_bash_script"
  chmod +x "$command_bash_script"

  # Submit the command bash script to qsub using the full path
  qsub -P $PROJECT -n $CPUS -q $QUEUE $OPTIONS -oo ${command_bash_script}.lsf.out $command_bash_script
  echo "qsub -P $PROJECT -n $CPUS -q $QUEUE $OPTIONS -oo ${command_bash_script}.lsf.out $command_bash_script"
  echo " "
 
  line_number=$((line_number + 1))
done <"$commands_file"

# Done
#mv $commands_file ${commands_file}.done
