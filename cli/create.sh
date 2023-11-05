#!/bin/bash
cli="$(dirname $0)"

bash $cli/clear.sh || exit 1
"$cli/sulfur" "${@:2}" || exit 1
bash $cli/compile.sh $@ || exit 1