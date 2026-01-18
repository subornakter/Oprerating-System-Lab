#!/bin/bash
declare -A users

while true; do
  echo -e "\n1. Create User\n2. Create File\n3. Delete File\n4. Search File\n5. Display User Files\n6. Exit"
  read -p "Enter choice: " ch

  case $ch in
    1)
      read -p "Enter username: " user
      if [ "${users[$user]+_}" ]; then
        echo "User already exists!"
      else
        users[$user]=""
        echo "User '$user' created."
      fi
      ;;
    2)
      read -p "Enter username: " user
      if [ "${users[$user]+_}" ]; then
        read -p "Enter filename: " file
        # Append file, space separated
        if [[ -z "${users[$user]}" ]]; then
          users[$user]="$file"
        else
          users[$user]="${users[$user]} $file"
        fi
        echo "File '$file' created under user '$user'."
      else
        echo "User not found!"
      fi
      ;;
    3)
      read -p "Enter username: " user
      read -p "Enter filename to delete: " file
      if [ "${users[$user]+_}" ]; then
        # Remove file from user's file list
        files=(${users[$user]})
        new_files=()
        for f in "${files[@]}"; do
          if [ "$f" != "$file" ]; then
            new_files+=("$f")
          fi
        done
        users[$user]="${new_files[*]}"
        echo "File '$file' deleted (if existed)."
      else
        echo "User not found!"
      fi
      ;;
    4)
      read -p "Enter username: " user
      read -p "Enter filename to search: " file
      if [ "${users[$user]+_}" ]; then
        files=(${users[$user]})
        found=0
        for f in "${files[@]}"; do
          if [ "$f" == "$file" ]; then
            found=1
            break
          fi
        done
        if [ $found -eq 1 ]; then
          echo "File '$file' found under user '$user'."
        else
          echo "File not found."
        fi
      else
        echo "User not found!"
      fi
      ;;
    5)
      for u in "${!users[@]}"; do
        echo "User: $u → Files: ${users[$u]}"
      done
      ;;
    6)
      exit ;;
    *)
      echo "Invalid choice" ;;
  esac
done
