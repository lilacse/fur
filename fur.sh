#!/bin/sh

export FUR_PWD="$PWD"

if cd "$(dirname "$(realpath "$0")")/"; then 
    python3 ./fur/main.py "$@"
else 
    echo "Failed to cd to fur's root directory." > /dev/stderr
    exit 1
fi
