#!/bin/bash
cd lib/builtin
rm linked.bc

for file in ./*.ll; do 
    [ -e "$file" ] || continue
    llvm-as "$file" -o "${file%.ll}.bc"
done

bc=(./*.bc)
llvm-link "${bc[@]}" -o linked.bc
