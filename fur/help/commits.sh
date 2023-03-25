#!/bin/sh

. "./fur/help/help_utilities/append_command_list.sh"

command="commits"
aliases=""

append_command_list "$command" "$aliases"

commits_help()
{
    echo "usage: fur commits [--branch | -b branch_override]"
    echo "opens the commits page for the specified branch of the repository on the remote's website."
}
