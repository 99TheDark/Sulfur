#!/bin/bash
shortfile="$(basename $1)"
name="${shortfile%.*}"

rm cli/tmp/*
bash cli/build.sh $@
"./cli/tmp/${name}"