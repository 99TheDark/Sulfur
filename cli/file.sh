#!/bin/bash
if [ -z "$1" ]; then
    echo "No file given"
    exit 1
fi

if ! [ -f "$1" ]; then 
    echo "$($1): No such file or directory" 
    exit 1
fi

name=$(basename -- "$1")
extension="${name##*.}"

noext=${1%.*}

if [ $extension != "su" ]; then 
    echo "A sulfur file should end in .su"
    exit 1
fi

echo $noext