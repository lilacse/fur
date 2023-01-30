#!/bin/sh

FUR_PWD="$PWD"

cd "$(dirname $(realpath $0))/fur/"

. ./main.sh

main "$@"
