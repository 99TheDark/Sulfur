#!/bin/bash
shortfile="$(basename $1)"
name="${shortfile%.*}"
bash cli/create.sh $name $@ || exit 1
"./cli/tmp/${name}" || exit 1