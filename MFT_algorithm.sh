#!/bin/bash


read -p "Enter the total memory available (in Bytes) -- " total_mem
read -p "Enter the block size (in Bytes) -- " block_size
read -p "Enter the number of processes -- " num_proc

declare -a processes
for ((i=1; i<=num_proc; i++))
do
    read -p "Enter memory required for process $i (in Bytes) -- " p
    processes[$i]=$p
done


num_blocks=$((total_mem / block_size))
echo -e "\nNo. of Blocks available in memory -- $num_blocks\n"


allocated=0
internal_frag=0
external_frag=0

echo -e "OUTPUT"
echo -e "PROCESS\tMEMORY REQUIRED\tALLOCATED\tINTERNAL FRAGMENTATION"

for ((i=1; i<=num_proc; i++))
do
    p=${processes[$i]}
    if [ $allocated -lt $num_blocks ]; then
        if [ $p -le $block_size ]; then
            allocated=$((allocated + 1))
            frag=$((block_size - p))
            internal_frag=$((internal_frag + frag))
            echo -e "$i\t$p\t\tYES\t\t$frag"
        else
            echo -e "$i\t$p\t\tNO\t\t-----"
        fi
    else
        echo -e "$i\t$p\t\tNO\t\t-----"
        external_frag=$((external_frag + p))
    fi
done


echo -e "\nMemory is Full, Remaining Processes cannot be accommodated"
echo "Total Internal Fragmentation is $internal_frag"
echo "Total External Fragmentation is $external_frag"
