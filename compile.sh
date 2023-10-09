#!/bin/bash
cd io/asm
llvm-as script.ll -o script.bc
cd ../../
sh lib/builtin/compile.sh
llvm-link lib/builtin/print.bc io/asm/script.bc -o io/asm/script-linked.bc
cd io/asm
llvm-dis script-linked.bc -o script-linked.ll
llc script-linked.bc -o script.asm
as -arch arm64 -o script.o script.asm
ld -o script script.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64
./script