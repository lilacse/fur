#!/bin/sh

. "./fur/help/help_utilities/append_command_list.sh"

command="nuke"
aliases=""

append_command_list "$command" "$aliases"

nuke_help()
{
    echo "usage: fur nuke"
    echo "fully return the state of the files in the repo to the last commit."
}
