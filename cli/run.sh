#!/bin/bash
shortfile="$(basename $1)"
name="${shortfile%.*}"

bash cli/clear.sh || exit 1
bash cli/create.sh $@ || exit 1
"./cli/tmp/${name}" || exit 1