#!/bin/sh

# usage: fur create-snapshot
# creates a branch for the current state of the repo, then soft resets back to the original branch. 

create_snapshot()
{
    if [ "$#" -ne 0 ]; then
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur create-snapshot" > /dev/stderr
        return 1
    fi

     # aborts if the repo is not on a named branch
    if ! current_branch=$(git -C "$FUR_PWD" symbolic-ref --short HEAD); then 
        echo "'create-snapshot' can only be used while on a branch." > /dev/stderr
        return 3
    fi
    
    snapshot_name=$(printf "_fur_snapshots/%s/%(%Y%m%d%H%M%S)T" "$current_branch")
    commit_message="fur: 'create-snapshot' command on $(date)"

    git -C "$FUR_PWD" add . 

    # aborts if the commit fail for any reason.
    if ! git -C "$FUR_PWD" -c commit.gpgsign=false commit -m "$commit_message" > /dev/null 2>&1; then 
        echo "Failed to create a commit for 'create-snapshot'. See output above for more information." > /dev/stderr
        return 2
    fi

    # aborts if the branch creation fail for any reason.
    if ! git -C "$FUR_PWD" switch -c "$snapshot_name" > /dev/null 2>&1; then 
        echo "Failed to create a branch for 'create-snapshot'. See output above for more information." > /dev/stderr
        return 3
    fi

    git -C "$FUR_PWD" switch "$current_branch" > /dev/null 2>&1
    git -C "$FUR_PWD" reset --mixed HEAD~1 > /dev/null 2>&1

    echo "Snapshot created at $snapshot_name"

    return 0
}
