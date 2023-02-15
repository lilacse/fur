#!/bin/sh

. "./utilities/handle_link.sh"
. "./utilities/process_remote_url.sh"
. "./utilities/get_remote_url.sh"

# usage: fur <pull-requests | prs>
# opens the pull requests page for the repository on the remote's website.

pull_requests()
{
    if [ "$#" -ne 0 ]; then 
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur <pull-requests | prs>" > /dev/stderr
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
        pr_page=$(printf "%s/pulls" "$remote")
        handle_link "$pr_page"
        return $?
    fi

    # handle Azure Devops repo

    echo "$remote" | grep -Eq "^https://dev.azure.com/.+/_git/.+$" 

    if [ "$?" -eq "0" ]; then 
        pr_page=$(printf "%s/pullrequests?_a=mine" "$remote")
        handle_link "$pr_page"
        return $?
    fi

    # fail otherwise as the link is unknown.

    echo "Pull requests link for remote ($remote) is not known!" > /dev/stderr
    return 2
}
