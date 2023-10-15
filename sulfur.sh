#!/bin/bash
./sulfur || exit 1
sh compile.sh || exit 1
./io/asm/script 