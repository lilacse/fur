#!/bin/sh

export FUR_PWD="$PWD"

if cd "$(dirname "$(realpath "$0")")/"; then 
    . ./fur/main.sh
    main "$@"
else 
    echo "Failed to cd to fur's root directory." > /dev/stderr
    exit 1
fi
