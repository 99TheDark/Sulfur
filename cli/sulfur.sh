#!/bin/bash
cli="$(dirname $0)"

allbut="${@:2}"
case $1 in 
    "run")
        bash $cli/run.sh $allbut || exit 1
        ;;
    "build")
        bash $cli/build.sh $allbut || exit 1
        ;;
    *)
        echo "Invalid or no mode selected"
        exit 1
        ;;
esac