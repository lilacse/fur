#!/bin/sh

. "./fur/help/help_utilities/append_command_list.sh"

command="help"
aliases=""

append_command_list "$command" "$aliases"

help_help()
{
    echo "usage: fur help [command]"
    echo "lists the available commands, or the command's help entry."
}
