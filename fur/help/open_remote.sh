#!/bin/sh

. "./fur/help/help_utilities/append_command_list.sh"

command="open-remote"
aliases=""

append_command_list "$command" "$aliases"

open_remote_help()
{
    echo "usage: fur open-remote [--branch branch_override]"
    echo "opens the repository's remote url."
}
