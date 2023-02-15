#!/bin/sh

. "./utilities/handle_link.sh"
. "./utilities/process_remote_url.sh"
. "./utilities/get_remote_url.sh"

# usage: fur <pull-request | pr> <pull_request_number>
# opens the pull request page for the given pull request number for the repository on the remote's website.

pull_request()
{
    if [ "$#" -ne 1 ]; then 
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur <pull-request | pr> <pull_request_number>" > /dev/stderr
        return 1
    fi

    remote="$(get_remote_url)"

    if [ "$?" -ne "0" ]; then
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

    echo "Pull request link for remote ($remote) is not known!" > /dev/stderr
    return 2
}

