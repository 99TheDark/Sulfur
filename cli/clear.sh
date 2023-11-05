#!/bin/bash
cli="$(dirname $0)"

# Check if directory isn't empty
if [ $(ls -A $cli/tmp | wc -l ) -ne 0 ]; then 
    rm $cli/tmp/* || exit 1
fi

if [ $(ls -A $cli/debug | wc -l ) -ne 0 ]; then 
    rm $cli/debug/* || exit 1
fi