#!/bin/sh

. "./fur/help/help_utilities/append_command_list.sh"

command="update-branch"
aliases="ub"

append_command_list "$command" "$aliases"

update_branch_help()
{
    echo "usage: fur <update-branch | ub> <branch> [git merge options]"
    echo "performs a git stash, switch, fetch, merge, and switches back to the original branch, restoring changes from stash, if any."
}
