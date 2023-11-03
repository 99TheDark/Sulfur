#!/bin/bash
go build || exit 1
bash lib/compile.sh || exit 1
cp sulfur cli/sulfur
bash cli/run.sh examples/main/script.su -colorless || exit 1