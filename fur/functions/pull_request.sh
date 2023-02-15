#!/bin/sh

. "./utilities/handle_link.sh"
. "./utilities/process_remote_url.sh"

# usage: fur <pull-request | pr> <pull_request_number>
# opens the pull request page for the given pull request number for the repository on the remote's website.

pull_request()
{
    if [ "$#" -ne 1 ]; then 
        echo "Invalid arguments."
        echo "usage: fur <pull-request | pr> <pull_request_number>"
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
        pr_page=$(printf "%s/pull/%s" "$remote" "$1")
        handle_link "$pr_page"
        return $?
    fi

    # fail otherwise as the link is unknown.

    echo "Pull request link for remote ($remote) is not known!"
    return 2
}

