#!/bin/sh

# usage: fur help [command]
# lists the available commands, or the command's help entry.

help()
{
    if [ "$#" -gt 1 ]; then 
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur help [command]" > /dev/stderr
        return 1
    fi

    help_files=$(find ./fur/help/ -maxdepth 1 -not -type d)
    for file in $help_files; do 
        #shellcheck source=/dev/null
        . "$file"
    done

    if [ -z "$commands_list" ]; then 
        echo "No commands are known to the help command (help files might be missing?)" > /dev/stderr
        return 3
    fi

    commands_list="$(echo "$commands_list" | sed '/^[[:space:]]*$/d')"
    if [ "$#" -eq 0 ]; then 
        echo "Available commands:"
        echo "$commands_list"
        return 0
    fi

    if ! echo "$commands_list" | grep -Eq "^$1$"; then 
        echo "Command not found: $1" > /dev/stderr
        return 2
    fi

    help_entry=$(echo "$1" | sed 's;-;_;g')
    if ! eval "$(printf "%s_help" "$help_entry")"; then 
        echo "Help function for '$1' is not found (please report a bug!)" > /dev/stderr
        return 2
    fi

    return 0
}
