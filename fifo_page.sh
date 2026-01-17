#!/bin/bash
# FIFO Page Replacement

read -p "Enter number of frames: " f
read -p "Enter number of pages: " n
echo "Enter the reference string (space separated): "
read -a pages

frame=()
page_faults=0
front=0

for ((i=0; i<n; i++))
do
    found=0
    for val in "${frame[@]}"; do
        if [ "$val" -eq "${pages[$i]}" ]; then
            found=1
            break
        fi
    done

    if [ $found -eq 0 ]; then
        if [ ${#frame[@]} -lt $f ]; then
            frame+=("${pages[$i]}")
        else
            frame[$front]=${pages[$i]}
            front=$(( (front+1) % f ))
        fi
        page_faults=$((page_faults+1))
    fi
    echo "Frame: ${frame[@]}"
done

echo "Total Page Faults = $page_faults"
