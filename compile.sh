#!/bin/bash
cd io/asm
llvm-as script.ll -o script.bc
llc script.bc -o script.asm
as -arch arm64 -o script.o script.asm
ld -o script script.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64
./script