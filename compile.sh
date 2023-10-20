#!/bin/bash
bash lib/compile.sh
cd io/asm
llvm-as script.ll -o script.bc || exit 1
cd ../../
llvm-link lib/builtin/linked.bc io/asm/script.bc -o io/asm/script-linked.bc || exit 1
cd io/asm
llvm-dis script-linked.bc -o script-linked.ll || exit 1
opt script-linked.bc -o script-optimized.bc || exit 1
llvm-dis script-optimized.bc -o script-optimized.ll || exit 1
llc script-optimized.bc -o script.asm -O=3 || exit 1
as -arch arm64 -o script.o script.asm || exit 1
ld -o script script.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64 || exit 1
./script # TODO: Remove