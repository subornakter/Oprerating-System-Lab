#!/bin/bash
# Single Level Directory Simulation

declare -A directory

while true
do
  echo -e "\n1. Create File\n2. Delete File\n3. Search File\n4. Display Files\n5. Exit"
  read -p "Enter choice: " ch
  case $ch in
    1)
      read -p "Enter file name: " name
      if [ "${directory[$name]}" ]; then
        echo "File already exists!"
      else
        directory[$name]=1
        echo "File '$name' created."
      fi
      ;;
    2)
      read -p "Enter file name to delete: " name
      if [ "${directory[$name]}" ]; then
        unset directory[$name]
        echo "File '$name' deleted."
      else
        echo "File not found."
      fi
      ;;
    3)
      read -p "Enter file name to search: " name
      if [ "${directory[$name]}" ]; then
        echo "File '$name' found."
      else
        echo "File not found."
      fi
      ;;
    4)
      echo "Files: ${!directory[@]}"
      ;;
    5)
      exit ;;
    *)
      echo "Invalid choice" ;;
  esac
done
