#!/bin/sh

main()
{
    # check if folder is a git repo

    git -C "$FUR_PWD" rev-parse &> /dev/null

    if [ "$?" -ne "0" ]; then 
        echo "Folder \"$FUR_PWD\" is not a git repo!"
        exit 3
    fi

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
