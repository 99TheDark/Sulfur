#!/bin/bash
shortfile="$(basename $1)"
name="${shortfile%.*}"

llvm-as "cli/tmp/${name}.ll" -o "cli/tmp/${name}.bc" || exit 1
llvm-link lib/builtin/linked.bc "cli/tmp/${name}.bc" -o "cli/tmp/${name}-linked.bc" || exit 1
llvm-dis "cli/tmp/${name}-linked.bc" -o "cli/tmp/${name}-linked.ll" || exit 1
opt "cli/tmp/${name}-linked.bc" -o "cli/tmp/${name}-optimized.bc" || exit 1
llvm-dis "cli/tmp/${name}-optimized.bc" -o "cli/tmp/${name}-optimized.ll" || exit 1
llc "cli/tmp/${name}-optimized.bc" -o "cli/tmp/${name}.asm" -O=3 || exit 1
as -arch arm64 -o "cli/tmp/${name}.o" "cli/tmp/${name}.asm" || exit 1
ld -o "cli/tmp/${name}" "cli/tmp/${name}.o" -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64 || exit 1