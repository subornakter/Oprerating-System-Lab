#!/bin/bash


echo "INPUT:"
echo "Enter the number of processes--"
read n

declare -a pid
declare -a bt
declare -a wt
declare -a tat


for ((i = 0; i < n; i++)); do
    pid[$i]=$((i))
    echo "Enter burst time for Process ${pid[$i]}--"
    read bt[$i]
done

wt[0]=0  

for ((i = 1; i < n; i++)); do
    wt[$i]=$((wt[$i-1] + bt[$i-1]))
done


for ((i = 0; i < n; i++)); do
    tat[$i]=$((wt[$i] + bt[$i]))
done


echo "OUTPUT:"
echo -e "\nProcess\tBurst Time\tWaiting Time\tTurnaround Time"
total_wt=0
total_tat=0

for ((i = 0; i < n; i++)); do
    echo -e "P${pid[$i]}\t${bt[$i]}\t\t${wt[$i]}\t\t${tat[$i]}"
    total_wt=$((total_wt + wt[$i]))
    total_tat=$((total_tat + tat[$i]))
done

avg_wt=$(echo "scale=6; $total_wt / $n" | bc)
avg_tat=$(echo "scale=6; $total_tat / $n" | bc)

echo -e "\nAverage Waiting Time-- $avg_wt"
echo "Average Turnaround Time-- $avg_tat"

