#!/bin/sh

export FUR_PWD="$PWD"

if cd "$(dirname "$(realpath "$0")")/"; then 
    . ./fur/main.sh
    main "$@"
fi
