#!/bin/sh

main()
{
    # check if folder is a git repo

    git -C "$FUR_PWD" rev-parse > /dev/null 2>&1

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
        open_remote "$@"
        exit $?
    elif [ "$1" = "recommit" ]; then 
        . "./functions/recommit.sh"
        shift 1
        recommit "$@"
        exit $?
    elif [ "$1" = "pull-requests" ]; then 
        . "./functions/pull_requests.sh"
        shift 1
        pull_requests "$@"
        exit $?
    elif [ "$1" = "create-pull-request" ]; then 
        . "./functions/create_pull_request.sh"
        shift 1
        create_pull_request "$@"
        exit $?
    elif [ "$1" = "issues" ]; then 
        . "./functions/issues.sh"
        shift 1
        issues "$@"
        exit $?
    else 
        echo "Option not understood: $1"
        exit 2
    fi
}
