#!/bin/bash

echo "INPUT"
echo -n "Enter number of processes: "
read n

for (( i=0; i<n; i++ ))
do
    echo -n "Enter burst time for process $((i))-- "
    read bt[$i]
    pid[$i]=$i
done

# Sort burst times using simple bubble sort
for (( i=0; i<n-1; i++ ))
do
    for (( j=0; j<n-i-1; j++ ))
    do
        if [ ${bt[j]} -gt ${bt[j+1]} ]
        then
            # Swap burst time
            temp=${bt[j]}
            bt[j]=${bt[j+1]}
            bt[j+1]=$temp

            # Swap process ID
            temp=${pid[j]}
            pid[j]=${pid[j+1]}
            pid[j+1]=$temp
        fi
    done
done

# Calculate waiting and turnaround times
wt[0]=0
tat[0]=${bt[0]}
total_wt=0
total_tat=0

for (( i=1; i<n; i++ ))
do
    wt[$i]=$(( wt[i-1] + bt[i-1] ))
    tat[$i]=$(( wt[i] + bt[i] ))
done

echo "OUTPUT"
echo -e "\nProcess\tBurst Time\tWaiting Time\tTurnaround Time"
for (( i=0; i<n; i++ ))
do
    echo -e "p${pid[$i]}\t${bt[i]}\t\t${wt[i]}\t\t${tat[i]}"
    total_wt=$(( total_wt + wt[i] ))
    total_tat=$(( total_tat + tat[i] ))
done

# Average calculations
avg_wt=$(echo "scale=6; $total_wt / $n" | bc)
avg_tat=$(echo "scale=6; $total_tat / $n" | bc)

echo -e "\nAverage Waiting Time-- $avg_wt"
echo -e "Average Turnaround Time-- $avg_tat"
