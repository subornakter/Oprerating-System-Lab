#!/bin/bash
# LRU Page Replacement

read -p "Enter number of frames: " f
read -p "Enter number of pages: " n
echo "Enter the reference string (space separated): "
read -a pages

frame=()
page_faults=0
declare -A recent

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
            lru_index=0
            min=${recent[${frame[0]}]}
            for ((k=0; k<${#frame[@]}; k++)); do
                if [ ${recent[${frame[$k]}]} -lt $min ]; then
                    min=${recent[${frame[$k]}]}
                    lru_index=$k
                fi
            done
            frame[$lru_index]=${pages[$i]}
        fi
        page_faults=$((page_faults+1))
    fi
    recent[${pages[$i]}]=$i
    echo "Frame: ${frame[@]}"
done

echo "Total Page Faults = $page_faults"
