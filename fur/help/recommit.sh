#!/bin/sh

. "./fur/help/help_utilities/append_command_list.sh"

command="recommit"
aliases=""

append_command_list "$command" "$aliases"

recommit_help()
{
    echo "usage: fur recommit [git commit options]"
    echo "soft-resets the last commit and make another commit including the currently staged changes."
}
