#!/bin/bash
echo "INPUT"
echo "Enter the number of processes -- "
read n

for (( i=0; i<n; i++ ))
do
    echo -n "Enter the Burst Time & Priority of Process $i --- "
    read bt[$i] pr[$i]
    pid[$i]=$i
done


for (( i=0; i<n-1; i++ ))
do
    for (( j=0; j<n-i-1; j++ ))
    do
        if [ ${pr[j]} -gt ${pr[j+1]} ]
        then
       
            temp=${pr[j]}
            pr[j]=${pr[j+1]}
            pr[j+1]=$temp

            temp=${bt[j]}
            bt[j]=${bt[j+1]}
            bt[j+1]=$temp

            temp=${pid[j]}
            pid[j]=${pid[j+1]}
            pid[j+1]=$temp
        fi
    done
done


wt[0]=0
tat[0]=${bt[0]}
total_wt=0
total_tat=0

for (( i=1; i<n; i++ ))
do
    wt[$i]=$(( wt[i-1] + bt[i-1] ))
    tat[$i]=$(( wt[i] + bt[i] ))
done

# Output
echo -e "\nOUTPUT"
echo -e "PROCESS\tPRIORITY\tBURST TIME\tWAITING TIME\tTURNAROUND TIME"

for (( i=0; i<n; i++ ))
do
    echo -e "${pid[i]}\t${pr[i]}\t\t${bt[i]}\t\t${wt[i]}\t\t${tat[i]}"
    total_wt=$(( total_wt + wt[i] ))
    total_tat=$(( total_tat + tat[i] ))
done


avg_wt=$(echo "scale=6; $total_wt / $n" | bc)
avg_tat=$(echo "scale=6; $total_tat / $n" | bc)

echo -e "\nAverage Waiting Time is --- $avg_wt"
echo -e "Average Turnaround Time is --- $avg_tat"

