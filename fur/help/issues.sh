#!/bin/sh

. "./fur/help/help_utilities/append_command_list.sh"

command="issues"
aliases="tasks, bugs, work-items"

append_command_list "$command" "$aliases"

issues_help()
{
    echo "usage: fur <issues | tasks | bugs | work-items>"
    echo "opens the issues page for the repository on the remote's website."
}
