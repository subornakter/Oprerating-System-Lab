#!/bin/bash
# Optimal Page Replacement

read -p "Enter number of frames: " f
read -p "Enter number of pages: " n
echo "Enter the reference string (space separated): "
read -a pages

frame=()
page_faults=0

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
            farthest=-1
            replace_index=0
            for ((k=0; k<${#frame[@]}; k++)); do
                next=-1
                for ((j=i+1; j<n; j++)); do
                    if [ ${frame[$k]} -eq ${pages[$j]} ]; then
                        next=$j
                        break
                    fi
                done
                if [ $next -eq -1 ]; then
                    replace_index=$k
                    break
                elif [ $next -gt $farthest ]; then
                    farthest=$next
                    replace_index=$k
                fi
            done
            frame[$replace_index]=${pages[$i]}
        fi
        page_faults=$((page_faults+1))
    fi
    echo "Frame: ${frame[@]}"
done

echo "Total Page Faults = $page_faults"
