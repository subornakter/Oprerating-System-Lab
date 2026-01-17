#!/bin/bash
# MVT (Multiprogramming with Variable Tasks) Algorithm Simulation

echo "Enter total memory available (in Bytes)--"
read ms

total=$ms
allocated=0

declare -a process
declare -a mem

i=0

while [ $ms -gt 0 ]
do
    echo "Enter memory required for process $((i+1)) (in Bytes)--"
    read req

    if [ $req -le $ms ]
    then
        process[$i]=$((i+1))
        mem[$i]=$req
        ms=$((ms - req))
        allocated=$((allocated + req))
        echo "Memory is allocated for Process $((i+1))"
    else
        echo "Memory is Full"
        break
    fi

    echo "Do you want to continue (y/n)--"
    read choice
    if [ "$choice" = "n" ]
    then
        break
    fi
    i=$((i+1))
done

echo
echo "Total Memory Available = $total"
echo
echo "PROCESS   MEMORY ALLOCATED"
for j in $(seq 0 $i)
do
    echo "   ${process[$j]}          ${mem[$j]}"
done

echo
echo "Total Memory Allocated = $allocated"
extfrag=$((total - allocated))
echo "Total External Fragmentation = $extfrag"

