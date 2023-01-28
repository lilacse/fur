#!/bin/sh

main()
{
    if [ "$#" -eq "0" ]; then 
        echo "No arguments supplied!"
        exit 1
    fi

    if [ "$1" = "remote" ]; then 
        . "./functions/remote.sh"
        shift 1
        remote $@
        exit $?
    else 
        echo "Option not understood: $1"
        exit 2
    fi
}
