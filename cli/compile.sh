#!/bin/bash
cli=$(dirname $0)

cur=$(pwd)
cd $cli
cd ../lib
lib=$(pwd)
cd $cur

llvm-as $cli/tmp/$1.ll -o $cli/tmp/$1.bc || exit 1
llvm-link $lib/builtin/linked.bc $cli/tmp/$1.bc -o $cli/tmp/$1-linked.bc || exit 1
llvm-dis $cli/tmp/$1-linked.bc -o $cli/tmp/$1-linked.ll || exit 1
opt $cli/tmp/$1-linked.bc -o $cli/tmp/$1-optimized.bc || exit 1
llvm-dis $cli/tmp/$1-optimized.bc -o $cli/tmp/$1-optimized.ll || exit 1
llc $cli/tmp/$1-optimized.bc -o $cli/tmp/$1.asm -O=3 || exit 1
as -arch arm64 -o $cli/tmp/$1.o $cli/tmp/$1.asm || exit 1
ld -o $cli/tmp/$1 $cli/tmp/$1.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64 || exit 1