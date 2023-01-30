#!/bin/sh

# usage: set_link_handler
# sets $FUR_LINK_HANDLER to a command to handle links

set_link_handler()
{
    platform=$(uname)

    # use `xdg-open` on Linux

    if [ "$platform" = "Linux" ]; then 
        export FUR_LINK_HANDLER="xdg-open"
        return 0
    fi

    # use `start` on Windows

    echo "$platform" | grep -Eq "^(MSYS)|(CYGWIN)|(MINGW(32)|(64))_NT"

    if [ "$?" -eq "0" ]; then 
        export FUR_LINK_HANDLER="start"
        return 0
    fi

    # return error for other platforms.

    echo "No command known to handle links with platform \"$platform\""
    return 1
}
