#!/bin/sh

main()
{
    # check if folder is a git repo
    if ! git -C "$FUR_PWD" rev-parse; then 
        echo "Folder \"$FUR_PWD\" is not a git repo!" > /dev/stderr
        exit 3
    fi
    

    if [ "$#" -eq "0" ]; then 
        echo "No arguments supplied!" > /dev/stderr
        exit 1
    fi


    case "$1" in 
        "open-remote")
            . "./fur/functions/open_remote.sh"
            shift 1
            open_remote "$@"
            exit $?
            ;;
        "recommit")
            . "./fur/functions/recommit.sh"
            shift 1
            recommit "$@"
            exit $?
            ;;
        "pull-requests" | "prs")
            . "./fur/functions/pull_requests.sh"
            shift 1
            pull_requests "$@"
            exit $?
            ;;
        "create-pull-request" | "cpr")
            . "./fur/functions/create_pull_request.sh"
            shift 1
            create_pull_request "$@"
            exit $?
            ;;
        "issues" | "tasks" | "bugs" | "work-items")
            . "./fur/functions/issues.sh"
            shift 1
            issues "$@"
            exit $?
            ;;
        "issue" | "task" | "bug" | "work-item")
            . "./fur/functions/issue.sh"
            shift 1
            issues "$@"
            exit $?
            ;;
        "pull-request" | "pr")
            . "./fur/functions/pull_request.sh"
            shift 1
            pull_request "$@"
            exit $?
            ;;
        "commits")
            . "./fur/functions/commits.sh"
            shift 1
            commits "$@"
            exit $?
            ;;
        "nuke")
            . "./fur/functions/nuke.sh"
            shift 1
            nuke "$@"
            exit $?
            ;;
        "create-snapshot")
            . "./fur/functions/create_snapshot.sh"
            shift 1
            create_snapshot "$@"
            exit $?
            ;;
        "help") 
            . "./fur/functions/help.sh"
            shift 1 
            help "$@"
            exit $?
            ;;
        "update-branch" | "ub")
            . "./fur/functions/update_branch.sh"
            shift 1
            update_branch "$@"
            exit $?
            ;;
        *)
            echo "Option not understood: $1" > /dev/stderr
            exit 2
            ;;
    esac
}
