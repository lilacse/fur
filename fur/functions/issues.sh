#!/bin/sh

. "./utilities/handle_link.sh"
. "./utilities/process_remote_url.sh"

# usage: fur issues
# opens the issues page for the repository on the remote's website.

issues()
{
    if [ "$#" -ne 0 ]; then 
        echo "Invalid arguments."
        echo "usage: fur issues"
        return 1
    fi

    remote="$(git -C "$FUR_PWD" config --get remote.origin.url)"

    if [ "$?" -eq "1" ]; then
        echo "Origin URL not set for this repository."
        return 3
    fi

    # cleanup/convert origin url beforehand.

    remote=$(process_remote_url "$remote")

    # handle GitHub repo

    echo "$remote" | grep -Eq "^https://github.com/.+$"

    if [ "$?" -eq "0" ]; then 
        issues_page=$(printf "%s/issues" "$remote")
        handle_link "$issues_page"
        return $?
    fi

    # fail otherwise as the link is unknown.

    echo "Issues link for remote ($remote) is not known!"
    return 2
}

