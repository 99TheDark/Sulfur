#!/bin/bash
go build
./sulfur
sh compile.sh
time ./io/asm/script