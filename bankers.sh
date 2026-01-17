#!/bin/bash

echo "BANKER'S ALGORITHM "

read -p "Enter number of processes: " n
read -p "Enter number of resources: " m

declare -a avail finish safe
declare -A alloc max need

echo "Enter available resources (space separated):"
read -a avail

echo "Enter allocation matrix (row-wise):"
for ((i=0; i<n; i++)); do
    echo -n "P$i: "
    read -a row
    for ((j=0; j<m; j++)); do
        alloc[$i,$j]=${row[$j]}
    done
done

echo "Enter max matrix (row-wise):"
for ((i=0; i<n; i++)); do
    echo -n "P$i: "
    read -a row
    for ((j=0; j<m; j++)); do
        max[$i,$j]=${row[$j]}
    done
done

# Need calculation
for ((i=0; i<n; i++)); do
    for ((j=0; j<m; j++)); do
        need[$i,$j]=$(( max[$i,$j] - alloc[$i,$j] ))
    done
done

# Print table ONCE
echo
echo "Process | Allocation | Max       | Need"
echo "--------------------------------------------"
for ((i=0; i<n; i++)); do
    printf "P%-3d   | " $i
    for ((j=0; j<m; j++)); do printf "%-2d " ${alloc[$i,$j]}; done
    printf "     | "
    for ((j=0; j<m; j++)); do printf "%-2d " ${max[$i,$j]}; done
    printf "     | "
    for ((j=0; j<m; j++)); do printf "%-2d " ${need[$i,$j]}; done
    echo
done
echo "--------------------------------------------"

# Print Available separately (dynamic)
echo -n "Available: "
for ((j=0; j<m; j++)); do echo -n "${avail[$j]} "; done
echo

# Banker logic
for ((i=0; i<n; i++)); do finish[$i]=0; done
count=0

while [ $count -lt $n ]; do
    found=0
    for ((i=0; i<n; i++)); do
        if [ ${finish[$i]} -eq 0 ]; then
            can_run=1
            for ((j=0; j<m; j++)); do
                if [ ${need[$i,$j]} -gt ${avail[$j]} ]; then
                    can_run=0
                    break
                fi
            done

            if [ $can_run -eq 1 ]; then
                echo
                echo ">>> P$i executed"

                for ((j=0; j<m; j++)); do
                    avail[$j]=$(( avail[$j] + alloc[$i,$j] ))
                done

                finish[$i]=1
                safe[$count]=$i
                count=$((count+1))
                found=1

                echo -n "Available: "
                for ((j=0; j<m; j++)); do echo -n "${avail[$j]} "; done
                echo
            fi
        fi
    done
    [ $found -eq 0 ] && break
done

echo
if [ $count -eq $n ]; then
    echo "System is in SAFE STATE"
    echo -n "Safe Sequence: "
    for ((i=0; i<n; i++)); do echo -n "P${safe[$i]} "; done
    echo
else
    echo "System is NOT in Safe State(Deadlock Possible)."
fi

