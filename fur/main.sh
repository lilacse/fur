#!/bin/sh

main()
{
    if [ "$#" -eq "0" ]; then 
        echo "No arguments supplied!"
        exit 1
    fi

    if [ "$1" = "open-remote" ]; then 
        . "./functions/open_remote.sh"
        shift 1
        open_remote $@
        exit $?
    else 
        echo "Option not understood: $1"
        exit 2
    fi
}
