#!/bin/bash
shortfile="$(basename $1)"
filedir="$(dirname $1)"
name="${shortfile%.*}"
bash cli/create.sh $name $@ || exit 1
mv "cli/tmp/${name}" "$filedir" || exit 1