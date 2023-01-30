#!/bin/sh

. "./utilities/handle_link.sh"

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
        return "$?"
    fi

    # only handle link if it is a http/https link

    echo "$remote" | grep -Eq "^https?://"

    if [ "$?" -eq "0" ]; then 
        handle_link "$remote"
    else 
        echo "Origin URL is not a http(s) link that can be opened: $remote"
        return 2
    fi
}
