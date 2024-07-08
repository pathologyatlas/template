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

# files=( $(find ./ -type f) )

# Get all tracked files, respecting .gitignore
# mapfile -t files < <(git ls-files)


# Get all tracked files
IFS=$'\n' read -d '' -r -a tracked_files < <(git ls-files)

# Get all untracked files, respecting .gitignore
IFS=$'\n' read -d '' -r -a untracked_files < <(git ls-files --others --exclude-standard)

# Combine tracked and untracked files
files=("${tracked_files[@]}" "${untracked_files[@]}")

batch_size=4000
total_files=${#files[@]}
batches=$((($total_files + $batch_size - 1) / $batch_size))
start_batch=0    # Define starting batch number

for ((i=$start_batch; i<$batches; i++))
do
  start=$((i*batch_size))
  end=$((start+batch_size-1))
  if [[ $end -gt $((total_files-1)) ]]; then
    end=$((total_files-1))
  fi
  echo "Processing files from $start to $end"
  for ((j=start; j<=end; j++))
  do
    if [ -e "${files[$j]}" ]; then
      git add "${files[$j]}"
      # echo "Added: ${files[$j]}"
    else
      git rm "${files[$j]}" 2>/dev/null && echo "Removed: ${files[$j]}" || echo "Skipped: ${files[$j]}"
    fi
  done
  
  # Check if there are changes to commit
  if git diff --cached --quiet; then
    echo "No changes to commit in this batch."
  else
    git commit -m "WIP Adding files from $start to $end"
    echo "Committing after adding files from $start to $end. There are $total_files files in total."
    echo "Batch number $((i+1)) is being processed."
    git push origin
    echo "Pushed files from $start to $end. There are $total_files files in total."
    echo "Batch number $((i+1)) has been processed."
  fi
  
  sleep 120
done

# Final check for any remaining untracked files
untracked=$(git ls-files --others --exclude-standard)
if [ -n "$untracked" ]; then
  echo "The following files are still untracked:"
  echo "$untracked"
  echo "You may want to add these manually or check your .gitignore file."
fi


