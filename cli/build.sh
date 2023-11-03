#!/bin/bash
first="${1-''}"
shortfile="$(basename $first)"
filedir="$(dirname $first)"
name="${shortfile%.*}"
bash cli/create.sh $name $@ || exit 1
mv "cli/tmp/${name}" "$filedir" || exit 1