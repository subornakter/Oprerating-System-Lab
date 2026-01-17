#!/bin/bash

echo "DINING PHILOSOPHER PROBLEM"

echo -n "Enter total number of philosophers: "
read n

echo -n "How many are hungry: "
read h

declare -a hungry

for ((i=0; i<h; i++))
do
    echo -n "Enter philosopher position $((i+1)): "
    read hungry[$i]
done

while true
do
    echo
    echo "OUTPUT"
    echo "1. One philosopher can eat at a time"
    echo "2. Two philosophers can eat at a time"
    echo "3. Exit"
    echo -n "Enter your choice: "
    read choice

    if [ $choice -eq 1 ]
    then
        echo
        echo "Allow one philosopher to eat at a time"
        for ((i=0; i<h; i++))
        do
            echo "P ${hungry[$i]} is eating"
            for ((j=0; j<h; j++))
            do
                if [ $i -ne $j ]
                then
                    echo "P ${hungry[$j]} is waiting"
                fi
            done
        done

    elif [ $choice -eq 2 ]
    then
        echo
        echo "Allow two philosophers to eat at a time"
        found=0

        for ((i=0; i<h; i++))
        do
            for ((j=i+1; j<h; j++))
            do
                diff=$(( hungry[$i] - hungry[$j] ))
                abs=${diff#-}

                if [ $abs -ne 1 ] && [ $abs -ne $((n-1)) ]
                then
                    echo "P ${hungry[$i]} and P ${hungry[$j]} are eating"
                    for ((k=0; k<h; k++))
                    do
                        if [ $k -ne $i ] && [ $k -ne $j ]
                        then
                            echo "P ${hungry[$k]} is waiting"
                        fi
                    done
                    found=1
                    break
                fi
            done
            [ $found -eq 1 ] && break
        done

        if [ $found -eq 0 ]
        then
            echo "No two philosophers can eat together (all are neighbours)"
        fi

    elif [ $choice -eq 3 ]
    then
        echo "Exiting..."
        exit 0

    else
        echo "Invalid choice"
    fi
done
