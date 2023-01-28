#!/bin/sh

FUR_PWD="$PWD"
PLATFORM="LINUX"

cd "$(dirname $(realpath $0))/fur/"

. ./main.sh

main $@
