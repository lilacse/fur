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


    case "$1" in 
        "open-remote")
            . "./functions/open_remote.sh"
            shift 1
            open_remote "$@"
            exit $?
            ;;
        "recommit")
            . "./functions/recommit.sh"
            shift 1
            recommit "$@"
            exit $?
            ;;
        "pull-requests" | "prs")
            . "./functions/pull_requests.sh"
            shift 1
            pull_requests "$@"
            exit $?
            ;;
        "create-pull-request" | "cpr")
            . "./functions/create_pull_request.sh"
            shift 1
            create_pull_request "$@"
            exit $?
            ;;
        "issues" | "tasks" | "bugs" | "work-items")
            . "./functions/issues.sh"
            shift 1
            issues "$@"
            exit $?
            ;;
        "issue" | "task" | "bug" | "work-item")
            . "./functions/issue.sh"
            shift 1
            issues "$@"
            exit $?
            ;;
        *)
            echo "Option not understood: $1"
            exit 2
            ;;
    esac
}
