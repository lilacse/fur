#!/bin/sh

. "./fur/help/help_utilities/append_command_list.sh"

command="pull-request"
aliases="pr"

append_command_list "$command" "$aliases"

pull_request_help()
{
    echo "usage: fur <pull-request | pr> <pull_request_number>"
    echo "opens the pull request page for the given pull request number for the repository on the remote's website."
}
