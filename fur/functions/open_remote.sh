#!/bin/sh

. "./utilities/handle_link.sh"
. "./utilities/convert_ssh_remote.sh"

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

    # converts SSH origin to http(s) links beforehand. 

    remote=$(convert_ssh_remote "$remote")

    if [ "$?" -ne "0" ]; then 

        # conversion failed, hence the url is not handle-able. 

        echo "Could not convert origin url ($remote) into a http(s) link."
        return 2
    fi

    # strip off username from Azure Devops's origin url.

    echo "$remote" | grep -Eq "^https://.+@dev.azure.com/.+/_git/.+$" 

    if [ "$?" -eq "0" ]; then 
        remote=$(echo "$remote" | sed 's;https://.\+@;https://;')
    fi
    
    handle_link "$remote"
    return $?
}
