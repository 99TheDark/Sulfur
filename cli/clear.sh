#!/bin/bash
# Check if directory isn't empty
if [ $(ls -A cli/tmp | wc -l ) -ne 0 ]; then 
    rm cli/tmp/*
fi

if [ $(ls -A cli/debug | wc -l ) -ne 0 ]; then 
    rm cli/debug/*
fi