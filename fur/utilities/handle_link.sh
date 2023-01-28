#!/bin/sh

# usage: handle_link [link]

handle_link()
{
    if [ "$#" -ne "1" ]; then 
        echo "Error in handle_link: Can only accept 1 argument, received $# instead."
        return 1
    fi

    if [ "$PLATFORM" = "LINUX" ]; then 
        xdg-open "$1"
    else 
        echo "No command known to handle links with platform \"$PLATFORM\""
    fi
}
