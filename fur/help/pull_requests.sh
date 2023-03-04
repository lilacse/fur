#!/bin/sh

. "./fur/help/help_utilities/append_command_list.sh"

command="pull-requests"
aliases="prs"

append_command_list "$command" "$aliases"

pull_requests_help()
{
    echo "usage: fur <pull-requests | prs>"
    echo "opens the pull requests page for the repository on the remote's website."
}
