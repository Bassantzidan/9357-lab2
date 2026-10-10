#!/bin/bash
dir="$1"
malicious_dir="$2"
flagged_extensions=(".exe" ".bat" ".vbs" ".scr" ".ps1")
flagged_contents=("virus" "trojan" "malware" "worm" "ransomware")
whitelist="whitelist"
scan()
{
  if [[ -z "$(ls "$dir")" ]]
then  
    return  
fi 
for file in "$dir"/* #for every file in the directory  can be written as "$1"/*
do 
  flag=0
  if grep -q -x "$(basename "$file")" "$whitelist" #-x means whole line must match exactly 
  then 
      continue
  fi 
   for flagged_extension in "${flagged_extensions[@]}"
   do 
      if [[ "$file" == *"$flagged_extension" ]]
      then 
          flag=1
          break
          
        fi
    done 
  if [[ $flag == 0 ]]
  then
   for flagged_content in "${flagged_contents[@]}"
   do
    if grep -q -i "$flagged_content" "$file"
    then 
      flag=1
      break
       
    fi
   done 
   fi
   if [[ $flag == 1 ]]
   then
       echo "$file is malicious and it is DELETED."
          cp "$file" "$malicious_dir"
          rm "$file"
    fi
done
}
if [[ ! -f "directory-info.last"]]
then
scan
ls -l "$dir" > directory-info.last
exit 
fi
ls -l "$dir" > directory-info.new
if cmp -s directory-info.last directory-info.new 
then 
    exit 
fi 
scan
cp directory-info.new directory-info.last
