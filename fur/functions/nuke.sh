#!/bin/sh

# usage: fur nuke 
# fully return the state of the files in the repo to the last commit. 

nuke()
{
    if [ "$#" -ne 0 ]; then
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur nuke" > /dev/stderr
        return 1
    fi

    commit_message="fur: 'nuke' command on $(date)"

    git -C "$FUR_PWD" add . 

    if ! git -C "$FUR_PWD" -c commit.gpgsign=false commit -m "$commit_message" > /dev/null 2>&1; then 
    
        # aborts if the commit fail for any reason.

        echo "Failed to create a temporary commit for 'nuke'. See output above for more information." > /dev/stderr
        return 2
    fi

    if ! git -C "$FUR_PWD" reset --hard HEAD~1; then 
        echo "Failed to reset to the commit before 'nuke' is executed (does the commit exists?)" > /dev/stderr
        return 2
    fi

    return 0
}
