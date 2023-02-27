#!/bin/sh

# usage: set_link_handler
# sets $FUR_LINK_HANDLER to a command to handle links

set_link_handler()
{
    if [ "$#" -ne "0" ]; then 
        echo "Error in set_link_handler: Can only accept 0 arguments, received $# instead." > /dev/stderr
        return 1
    fi

    platform=$(uname)

    # use `xdg-open` on Linux
    if [ "$platform" = "Linux" ]; then 
        export FUR_LINK_HANDLER="xdg-open"
        return 0
    fi

    # use `start` on Windows
    if echo "$platform" | grep -Eq "^(MSYS)|(CYGWIN)|(MINGW(32)|(64))_NT"; then 
        export FUR_LINK_HANDLER="start"
        return 0
    fi

    # return error for other platforms.
    echo "No command known to handle links with platform \"$platform\"" > /dev/stderr
    return 1
}
