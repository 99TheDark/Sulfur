#!/bin/bash
set -o pipefail
case $1 in 
    run)
        noext=<(bash cli/file.sh $2)
        lli <(llvm-link <(./sulfur | llvm-as) lib/builtin/linked.bc | opt)
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