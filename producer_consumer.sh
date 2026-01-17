#!/bin/bash

buffer=0
full=0

produce() {
    if [ $full -eq 1 ]
    then
        echo "Buffer is Full"
    else
        echo -n "Enter the value: "
        read buffer
        full=1
    fi
}

consume() {
    if [ $full -eq 0 ]
    then
        echo "Buffer is Empty"
    else
        echo "The consumed value is $buffer"
        buffer=0
        full=0
    fi
}

while true
do
    echo
    echo "1. Produce    2. Consume    3. Exit"
    echo -n "Enter your choice: "
    read choice

    case $choice in
        1) produce ;;
        2) consume ;;
        3) exit 0 ;;
        *) echo "Invalid choice" ;;
    esac
done
