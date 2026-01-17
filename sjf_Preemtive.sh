#!/bin/bash

echo -n "Enter number of processes: "
read n

for (( i=0; i<n; i++ ))
do
    echo -n "Enter arrival time for process $((i+1)): "
    read at[$i]
    echo -n "Enter burst time for process $((i+1)): "
    read bt[$i]
    rem_bt[$i]=${bt[$i]}   # Remaining burst time
    pid[$i]=$i
done

completed=0
time=0
min=9999
shortest=-1
finish_time=0
total_wt=0
total_tat=0

for (( i=0; i<n; i++ ))
do
    wt[$i]=0
    tat[$i]=0
    done_flag[$i]=0
done

echo -e "\nGantt Chart:"

while (( completed != n ))
do
    shortest=-1
    min=9999

    for (( i=0; i<n; i++ ))
    do
        if (( at[i] <= time && rem_bt[i] > 0 && rem_bt[i] < min ))
        then
            min=${rem_bt[i]}
            shortest=$i
        fi
    done

    if (( shortest == -1 ))
    then
        ((time++))
        continue
    fi

    echo -n "|P$((shortest+1)) "

    (( rem_bt[shortest]-- ))
    (( time++ ))

    if (( rem_bt[shortest] == 0 ))
    then
        completed=$((completed + 1))
        finish_time=$time
        tat[shortest]=$(( finish_time - at[shortest] ))
        wt[shortest]=$(( tat[shortest] - bt[shortest] ))

        total_wt=$(( total_wt + wt[shortest] ))
        total_tat=$(( total_tat + tat[shortest] ))
    fi
done

echo "|"

echo -e "\nProcess\tArrival Time\tBurst Time\tWaiting Time\tTurnAroundTime"
for (( i=0; i<n; i++ ))
do
    echo -e "$((i+1))\t\t${at[i]}\t\t${bt[i]}\t\t${wt[i]}\t\t${tat[i]}"
done

avg_wt=$(echo "scale=2; $total_wt / $n" | bc)
avg_tat=$(echo "scale=2; $total_tat / $n" | bc)

echo -e "\nAverage Waiting Time: $avg_wt"
echo -e "Average Turnaround Time: $avg_tat"
