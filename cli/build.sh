#!/bin/bash
./sulfur build $@ || exit 1
bash cli/compile.sh $@ || exit 1