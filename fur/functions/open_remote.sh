#!/bin/sh

. "./utilities/handle_link.sh"

# usage: fur remote [--show] 
# opens or shows the repository's remote url.

open_remote()
{
    remote="$(git -C "$FUR_PWD" config --get remote.origin.url)"

    if [ "$?" -eq "1" ]; then
        echo "Origin URL not set for this repository."
        return "$?"
    fi

    # only handle link if it is a http/https link

    echo "$remote" | grep -Eq "^https?://"

    if [ "$?" -eq "0" ]; then 
        handle_link "$url"
    else 
        echo "Origin URL is not a http(s) link that can be opened: $remote"
        return 1
    fi
}
