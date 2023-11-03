#!/bin/bash
./sulfur run $@ || exit 1
bash cli/compile.sh $@ || exit 1