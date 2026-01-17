#!/bin/bash
echo "INPUT:"
echo  "Enter the number of processes-- "
read n

declare -a pid bt rt wt tat completed

# Input burst times
for ((i=0; i<n; i++))
do
    pid[i]=$((i+1))
    echo -n "Enter Burst Time for process $((i+1)) -- "
    read bt[i]
    rt[i]=${bt[i]}
    wt[i]=0
    tat[i]=0
    completed[i]=0
done

# Input time quantum
echo -n "Enter the size of time slice -- "
read tq

# Round Robin Logic
time=0
remain=$n

while (( remain > 0 ))
do
    for ((i=0; i<n; i++))
    do
        if (( rt[i] > 0 ))
        then
            if (( rt[i] > tq ))
            then
                time=$((time + tq))
                rt[i]=$((rt[i] - tq))
            else
                time=$((time + rt[i]))
                wt[i]=$((time - bt[i]))
                rt[i]=0
                tat[i]=$((bt[i] + wt[i]))
                completed[i]=1
                remain=$((remain - 1))
            fi
        fi
    done
done

# Output
echo -e "\nOUTPUT:"
echo -e "PROCESS\tBURST TIME\tWAITING TIME\tTURNAROUND TIME"

total_wt=0
total_tat=0
for ((i=0; i<n; i++))
do
    echo -e "${pid[i]}\t${bt[i]}\t\t${wt[i]}\t\t${tat[i]}"
    total_wt=$((total_wt + wt[i]))
    total_tat=$((total_tat + tat[i]))
done

# Averages with decimals
avg_wt=$(echo "scale=6; $total_wt / $n" | bc)
avg_tat=$(echo "scale=6; $total_tat / $n" | bc)

echo -e "\nThe Average Turnaround time is-- $avg_tat"
echo -e "Average Waiting time is----------- $avg_wt"
