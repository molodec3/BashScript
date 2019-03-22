#!/bin/bash

i=1
cd "$HOME"
name_dir=$1

if [ -d "$name_dir" ]; then
  #checking name avaliability
  #for making a new dir
  j=1
  while [ -d "$name_dir$j" ]
  do
    j=$(( $j+1 ))
  done
  mv $name_dir $name_dir$j
fi
mkdir $name_dir

for item in "$@"; do
  #coping everything with required extension
  #saving dir's structure
  if [ $i -eq $# ]; then
    final_name=$item
  elif [ $i -gt 1 ]; then
    extension=$item
    find -not -path "./$name_dir/*" -name "*$extension" 1>/dev/null 2>&1 -exec cp --parents {} $name_dir \;
  fi
  i=$(( $i+1 ))
done

#making archive
tar -czf $final_name.tar $name_dir
echo "done"
