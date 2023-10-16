#!/bin/bash
set -o pipefail
function file() {
    if [ -z "$1" ]; then
        echo "No file given"
        exit 1
    fi

    if ! [ -f "$1" ]; then 
        echo "$($1): No such file or directory" 
        exit 1
    fi

    name=$(basename -- "$1")
    extension="${name##*.}"

    noext=${1%.*}

    if [ $extension != "su" ]; then 
        echo "A sulfur file should end in .su"
        exit 1
    fi

    echo $noext
}

case $1 in 
    run)
        noext=$(file) || exit 1
        # lli <(llvm-link <(./sulfur | llvm-as) lib/builtin/linked.bc | opt)
        ;;

    build)
        noext=<(bash cli/file.sh $2)
        as <(llvm-link <(./sulfur | llvm-as) lib/builtin/linked.bc | opt | llc) -arch arm64 -o "$noext.o"
        ld "$noext.o" -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64 -o "$noext"
        rm "$noext.o"
        "./$noext"
        ;;

    *)
        echo "Unknown command $1"
        ;;
esac