#!/bin/sh

. "./utilities/set_link_handler.sh"

# usage: handle_link [link]

handle_link()
{
    if [ "$#" -ne "1" ]; then 
        echo "Error in handle_link: Can only accept 1 argument, received $# instead."
        return 1
    fi

    set_link_handler

    if [ "$?" -eq "0" ]; then 
        $FUR_LINK_HANDLER "$1"
        return $?
    fi

    return $?
}
