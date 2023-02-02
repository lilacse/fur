#!/bin/sh

. "./utilities/handle_link.sh"
. "./utilities/process_remote_url.sh"

# usage: fur open-remote
# opens the repository's remote url.

open_remote()
{
    if [ "$#" -ne 0 ]; then 
        echo "Invalid arguments."
        echo "usage: fur open-remote"
        return 1
    fi

    remote="$(git -C "$FUR_PWD" config --get remote.origin.url)"

    if [ "$?" -eq "1" ]; then
        echo "Origin URL not set for this repository."
        return 3
    fi

    # cleanup/convert origin url beforehand.

    remote=$(process_remote_url "$remote")

    if [ "$?" -ne "0" ]; then 

        # conversion failed, hence the url is not handle-able. 

        echo "Handling for origin url ($remote) is unknown."
        return 2
    fi
    
    handle_link "$remote"
    return $?
}
