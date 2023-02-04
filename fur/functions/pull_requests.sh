#!/bin/sh

. "./utilities/handle_link.sh"
. "./utilities/process_remote_url.sh"

# usage: fur pull_requests 
# opens the pull requests page for the repository on the remote's website.

pull_requests()
{
    if [ "$#" -ne 0 ]; then 
        echo "Invalid arguments."
        echo "usage: fur pull_requests"
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

    echo "Pull requests link for remote ($remote) is not known!"
    return 2
}
