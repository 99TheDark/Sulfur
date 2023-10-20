#!/bin/bash
go build || exit 1
bash lib/compile.sh || exit 1
sh sulfur.sh || exit 1