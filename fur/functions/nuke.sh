#!/bin/sh

# usage: fur nuke 
# fully return the state of the files in the repo to the last commit. 

nuke()
{
    if ! options=$(getopt -a -u --longoptions "clean" -- "c" "$@"); then
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur nuke [--clean | -c]" > /dev/stderr
        return 1
    fi

    # shellcheck disable=SC2086
    set -- $options

    is_clean=false

    while true; do 
        if [ "$1" = "--clean" ] || [ "$1" = "-c" ]; then 
            is_clean=true
            shift 
        elif [ "$1" = "--" ]; then 
            shift
            break;
        fi
    done

    commit_message="fur: 'nuke' command on $(date)"

    git -C "$FUR_PWD" add . 

    # aborts if the commit fail for any reason.
    if ! git -C "$FUR_PWD" -c commit.gpgsign=false commit -m "$commit_message"; then 
        echo "Failed to create a temporary commit for 'nuke'. See output above for more information." > /dev/stderr
        return 2
    fi

    if ! git -C "$FUR_PWD" reset --hard HEAD~1; then 
        echo "Failed to reset to the commit before 'nuke' is executed (does the commit exists?)" > /dev/stderr
        return 2
    fi

    if [ $is_clean ]; then 
        git clean -fdx
    fi

    return 0
}
