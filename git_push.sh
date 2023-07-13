#!/bin/bash

# chmod +x git_push.sh
# ./git_push.sh

# git add *.qmd
# git commit -m "qmd files"
# git add *.yml
# git commit -m "yml files"
# git push origin

# git lfs track "*.pdf"
# git lfs track "*.docx"
# git lfs track "*.epub"

# git lfs track

# git lfs untrack "*.pdf"
# git lfs untrack "*.docx"
# git lfs untrack "*.epub"

# increases the git http buffer size to 500 MB
# git config --global http.postBuffer 524288000

items=( $(find ./ -type f -o -type d) )   # Find all files and directories

# files=( $(find ./CD3_files -type f) )

batch_size=2000
total_items=${#items[@]}
batches=$((($total_items + $batch_size - 1) / $batch_size))


start_batch=0    # Define starting batch number


for ((i=$start_batch; i<$batches; i++))
do
  start=$((i*batch_size))
  end=$((start+batch_size-1))

  if [[ $end -gt $((total_items-1)) ]]; then
    end=$((total_items-1))
  fi

  echo "Processing items from $start to $end"
  for ((j=start; j<=end; j++))
  do
    if [ -e "${items[$j]}" ]; then
      git add "${items[$j]}"
    else
      git rm -r "${items[$j]}"   # The -r option allows git rm to delete directories
    fi
  done

  git commit -m "WIP Adding items from $start to $end"
  echo "Committing after adding items from $start to $end. There are $total_items items in total."
  echo "Batch number $((i+1)) is being processed."
  git push origin
  echo "Pushed items from $start to $end. There are $total_items items in total."
  echo "Batch number $((i+1)) has been processed."
  sleep 120
done
