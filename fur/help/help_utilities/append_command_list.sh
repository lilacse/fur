#!/bin/sh

# usage: append_command_list <command> [aliases] 
# Appends the command and its aliases to the `commands_list` variable.

append_command_list()
{
    if [ "$#" -lt "1" ] || [ "$#" -gt "2" ]; then 
        echo "Error in append_command_list: Can only accept 1 or 2 arguments, received $# instead." > /dev/stderr
        return 1
    elif [ -z "$2" ]; then 
        commands_list=$(printf "%s\n%s" "$commands_list" "$1")
    else 
        commands_list=$(printf "%s\n%s (%s)" "$commands_list" "$1" "$2")
    fi 

    export commands_list
    return 0
}
