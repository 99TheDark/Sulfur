#!/bin/bash
go build || exit 1
bash lib/compile.sh || exit 1
cp sulfur cli/sulfur
./cli/sulfur run examples/main/script.su -trace -colorless -debug || exit 1