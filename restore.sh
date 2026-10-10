#!/bin/bash
dir="$1"
malicious_dir="$2"
whitelist="whitelist"
if [[ -z "$(ls "$malicious_dir")" ]]
then
    echo "No malicious files to review."
    exit 
fi
while true
do
files=()
counter=1
for file in "$malicious_dir"/*
do 
  echo "$counter.$(basename "$file")"
  files[counter-1]="$file"
  ((counter++))
done 
echo "Enter file number:"
read choice 
selected_file="${files[$choice-1]}"
echo "menu:"
echo "1.Restore this file back into dir"
echo "2.permanently delete this file from malicious_dir"
echo "3.leave this file as-is and go back to list"
read action 
if [[ $action == 1 ]]
then 
    mv "$selected_file" "$dir"
    echo "Restored $(basename "$selected_file") to $(basename "$dir")."
    echo "$(basename "$selected_file")" >> "$whitelist"
fi 
if [[ $action == 2 ]]
then 
    rm "$selected_file"
    echo "$(basename "$selected_file") permanently deleted."
fi
if [[ $action == 3 ]]
then 
    continue
fi 
done 