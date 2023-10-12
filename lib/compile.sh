#!/bin/bash
cd lib/builtin
rm linked.bc

for file in **/*.ll; do 
    [ -e "$file" ] || continue
    name=$(basename ${file%.ll})
    llvm-as "$file" -o "bytecode/${name}.bc"
done

bc=(./bytecode/*.bc)
llvm-link "${bc[@]}" -o linked.bc
