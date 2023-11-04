#!/bin/bash
go build || exit 1
bash lib/compile.sh || exit 1
cp sulfur cli/sulfur
bash cli/sulfur.sh run examples/main/script.su -trace -colorless -debug || exit 1