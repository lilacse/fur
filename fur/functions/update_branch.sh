#!/bin/sh

# usage: fur <update-branch | ub> <branch> [git merge options]
# performs a git stash, switch, fetch, merge, and switches back to the original branch, restoring changes from stash, if any.

update_branch()
{
    if [ "$#" -eq 0 ]; then 
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur <update-branch | ub> <branch> [git merge options]" > /dev/stderr
        return 1
    fi;

    current_branch=$(git -C "$FUR_PWD" symbolic-ref --short HEAD)
    target_branch="$1"
    shift

    is_need_stash=false
    if [ "$(git -C "$FUR_PWD" status -s | wc -l)" != "0" ]; then 
        is_need_stash=true
    fi

    if [ $is_need_stash = true ]; then 
        git -C "$FUR_PWD" stash --all
    fi

    git -C "$FUR_PWD" switch "$target_branch" || return 2
    git -C "$FUR_PWD" fetch || return 2
    # shellcheck disable=2068 
    git -C "$FUR_PWD" merge $@ || return 2
    git -C "$FUR_PWD" switch "$current_branch" || return 2
    
    if [ $is_need_stash = true ]; then 
        git -C "$FUR_PWD" stash pop || return 2
    fi

    return 0
}
