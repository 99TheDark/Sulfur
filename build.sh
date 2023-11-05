#!/bin/bash
go build || exit 1
bash lib/compile.sh || exit 1
cp sulfur cli/sulfur
# bash cli/sulfur.sh run examples/main/script.su -trace -colorless -debug -o output || exit 1
./cli/sulfur build examples/main/script.su -trace -colorless -debug -o examples/main/output || exit 1