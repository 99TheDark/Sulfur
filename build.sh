#!/bin/bash
go build || exit 1
bash lib/compile.sh || exit 1
cp sulfur cli/sulfur
bash cli/run.sh examples/complex_mix.su -trace -color -debug || exit 1