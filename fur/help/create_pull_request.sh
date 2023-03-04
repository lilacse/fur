#!/bin/sh

. "./fur/help/help_utilities/append_command_list.sh"

command="create-pull-request"
aliases="cpr"

append_command_list "$command" "$aliases"

create_pull_request_help()
{
    echo "usage: fur <create-pull-request | cpr> [--from source_repo] [--to target_repo]"
    echo "opens the create pull request page for the repository on the remote's website."
}
