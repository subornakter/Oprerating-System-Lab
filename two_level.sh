#!/bin/bash
# Two Level Directory Simulation

declare -A users

while true
do
  echo -e "\n1. Create User\n2. Create File\n3. Delete File\n4. Search File\n5. Display User Files\n6. Exit"
  read -p "Enter choice: " ch

  case $ch in
    1)
      read -p "Enter username: " user
      if [ "${users[$user]}" ]; then
        echo "User already exists!"
      else
        users[$user]=""
        echo "User '$user' created."
      fi
      ;;
    2)
      read -p "Enter username: " user
      if [ "${users[$user]}" ]; then
        read -p "Enter filename: " file
        users[$user]="${users[$user]} $file"
        echo "File '$file' created under user '$user'."
      else
        echo "User not found!"
      fi
      ;;
    3)
      read -p "Enter username: " user
      read -p "Enter filename to delete: " file
      files=${users[$user]}
      users[$user]=$(echo $files | sed "s/\b$file\b//g")
      echo "File '$file' deleted (if existed)."
      ;;
    4)
      read -p "Enter username: " user
      read -p "Enter filename to search: " file
      if echo "${users[$user]}" | grep -wq "$file"; then
        echo "File '$file' found under user '$user'."
      else
        echo "File not found."
      fi
      ;;
    5)
      for user in "${!users[@]}"; do
        echo "User: $user → Files: ${users[$user]}"
      done
      ;;
    6)
      exit ;;
    *)
      echo "Invalid choice" ;;
  esac
done
