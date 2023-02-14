#!/bin/sh

. "./utilities/handle_link.sh"
. "./utilities/process_remote_url.sh"

# usage: fur issue [issue_number]
# opens the issue page for the given issue number for the repository on the remote's website.

issues()
{
    if [ "$#" -ne 1 ]; then 
        echo "Invalid arguments."
        echo "usage: fur issue [issue_number]"
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
        issue_page=$(printf "%s/issues/%s" "$remote" "$1")
        handle_link "$issue_page"
        return $?
    fi

    # fail otherwise as the link is unknown.

    echo "Issue link for remote ($remote) is not known!"
    return 2
}

