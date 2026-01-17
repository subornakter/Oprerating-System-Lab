#!/bin/bash

echo -n "Enter number of blocks: "
read nb
echo -n "Enter number of files: "
read nf

declare -a block file allocation fragment used_block

echo "Enter block sizes:"
for ((i=0;i<nb;i++)); do
  read -p "Block $((i+1)): " block[$i]
done

echo "Enter file sizes:"
for ((i=0;i<nf;i++)); do
  read -p "File $((i+1)): " file[$i]
done

for ((i=0;i<nf;i++)); do
  worst=-1
  for ((j=0;j<nb;j++)); do
    if [ ${block[$j]} -ge ${file[$i]} ]; then
      if [ $worst -eq -1 ] || [ ${block[$j]} -gt ${block[$worst]} ]; then
        worst=$j
      fi
    fi
  done
  if [ $worst -ne -1 ]; then
    allocation[$i]=$worst
    fragment[$i]=$((block[$worst]-file[$i]))
    used_block[$i]=${block[$worst]}
    block[$worst]=-1
  else
    allocation[$i]=-1
  fi
done

echo -e "\nFileNo\tFileSize\tBlockNo\tBlockSize\tFragment"
for ((i=0;i<nf;i++)); do
  if [ ${allocation[$i]} -ne -1 ]; then
    echo -e "$((i+1))\t${file[$i]}\t\t$((allocation[$i]+1))\t${used_block[$i]}\t\t${fragment[$i]}"
  else
    echo -e "$((i+1))\t${file[$i]}\t\tNot Allocated"
  fi
done
