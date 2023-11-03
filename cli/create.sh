#!/bin/bash
bash cli/clear.sh || exit 1
./sulfur "${@:2}" || exit 1
bash cli/compile.sh $@ || exit 1