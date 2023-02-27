#!/bin/sh

. "./fur/utilities/handle_link.sh"
. "./fur/utilities/process_remote_url.sh"
. "./fur/utilities/get_remote_url.sh"

# usage: fur <pull-request | pr> <pull_request_number>
# opens the pull request page for the given pull request number for the repository on the remote's website.

pull_request()
{
    if [ "$#" -ne 1 ]; then 
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur <pull-request | pr> <pull_request_number>" > /dev/stderr
        return 1
    fi

    # shellcheck disable=SC2119
    if ! remote="$(get_remote_url)"; then
        return 3
    fi

    # cleanup/convert origin url beforehand.
    remote=$(process_remote_url "$remote")

    # handle GitHub repo
    if echo "$remote" | grep -Eq "^https://github.com/.+$"; then 
        pr_page=$(printf "%s/pull/%s" "$remote" "$1")
        handle_link "$pr_page"
        return $?
    fi

    # handle Azure Devops repo
    if echo "$remote" | grep -Eq "^https://dev.azure.com/"; then 
        pr_page=$(printf "%s/pullrequest/%s" "$remote" "$1")
        handle_link "$pr_page"
        return $?
    fi

    # fail otherwise as the link is unknown.
    echo "Pull request link for remote ($remote) is not known!" > /dev/stderr
    return 2
}

