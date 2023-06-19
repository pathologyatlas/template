#!/bin/bash

# chmod +x git_push.sh

files=( $(find ./HE_files -type f) )   # Find all files in the current directory and subdirectories
batch_size=4000                 # Define the batch size
total_files=${#files[@]}       # Get total number of files
batches=$((($total_files + $batch_size - 1) / $batch_size))

for ((i=0; i<$batches; i++))
do
  start=$((i*batch_size))
  end=$((start+batch_size-1))

  if [[ $end -gt $((total_files-1)) ]]; then
    end=$((total_files-1))
  fi

  echo "Adding files from $start to $end"
  for ((j=start; j<=end; j++))
  do
    git add "${files[$j]}"
  done

  git commit -m "Adding files from $start to $end"
  git push
done
