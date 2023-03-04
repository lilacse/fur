#!/bin/sh

. "./fur/help/help_utilities/append_command_list.sh"

command="issue"
aliases="task, bug, work-item"

append_command_list "$command" "$aliases"

issue_help()
{
    echo "usage: fur <issue | task | bug | work-item> <issue_number>"
    echo "opens the issue page for the given issue number for the repository on the remote's website."
}
