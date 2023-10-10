#!/bin/bash
cd lib/builtin
for file in ./*.ll; do 
    [ -e "$file" ] || continue
    llvm-as "$file" -o "${file%.ll}.bc"
done