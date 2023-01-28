#!/bin/sh

. "./utilities/handle_link.sh"

# usage: fur remote [--show] 
# opens or shows the repository's remote url.

remote()
{
    cd "$FUR_PWD"

    url="$(git config --get remote.origin.url)"

    if [ "$?" -eq "1" ]; then
        echo "Repository has no upstream url."
        return "$?"
    fi
    
    if [ "$1" = "--show" ]; then
        echo "$url"
        return "$?"
    fi

    handle_link "$url"
}
