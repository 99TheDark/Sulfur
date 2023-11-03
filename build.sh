#!/bin/bash
go build || exit 1
cp sulfur cli/sulfur
bash lib/compile.sh || exit 1
bash sulfur.sh || exit 1 