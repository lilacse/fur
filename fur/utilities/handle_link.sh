#!/bin/sh

. "./utilities/set_link_handler.sh"

# usage: handle_link <link>
# opens the link in an appropriate program selected by a system utility (`start` on Windows, `xdg-open` on Linux).

handle_link()
{
    if [ "$#" -ne "1" ]; then 
        echo "Error in handle_link: Can only accept 1 argument, received $# instead." > /dev/stderr
        return 1
    fi

    set_link_handler

    if [ "$?" -eq "0" ]; then 
        $FUR_LINK_HANDLER "$1"
        return $?
    fi

    return $?
}
