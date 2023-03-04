#!/bin/sh

. "./fur/help/help_utilities/append_command_list.sh"

command="create-snapshot"
aliases=""

append_command_list "$command" "$aliases"

create_snapshot_help()
{
    echo "usage: fur create-snapshot"
    echo "creates a branch for the current state of the repo, then soft resets back to the original branch."
}
