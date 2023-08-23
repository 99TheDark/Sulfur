#!/bin/bash
cd io
cd asm
llvm-as script.ll -o script.bc
llc script.bc -o script.s
as -arch arm64 -o script.o script.s
ld -o script script.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64
./script