#!/bin/bash
bash build.sh
./cli/sulfur run examples/main/script.su -trace -colorless -debug || exit 1