#!/bin/bash
cli="$(dirname $0)"

first="${1-''}"
shortfile="$(basename $first)"
name="${shortfile%.*}"
bash $cli/create.sh $name $@ || exit 1
"$cli/tmp/$name" || exit 1