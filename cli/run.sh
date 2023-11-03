#!/bin/bash
shortfile="$(basename $1)"
name="${shortfile%.*}"

# Check if directory isn't empty
if [ $(ls -A cli/tmp | wc -l ) -ne 0 ]; then 
    rm cli/tmp/*
fi

bash cli/build.sh $@ || exit 1
"./cli/tmp/${name}" || exit 1