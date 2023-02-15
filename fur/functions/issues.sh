#!/bin/sh

. "./utilities/handle_link.sh"
. "./utilities/process_remote_url.sh"
. "./utilities/get_remote_url.sh"

# usage: fur <issues | tasks | bugs | work-items>
# opens the issues page for the repository on the remote's website.

issues()
{
    if [ "$#" -ne 0 ]; then 
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur <issues | tasks | bugs | work-items>" > /dev/stderr
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
        issues_page=$(printf "%s/issues" "$remote")
        handle_link "$issues_page"
        return $?
    fi

    # handle Azure Devops repo

    echo "$remote" | grep -Eq "^https://dev.azure.com/"

    if [ "$?" -eq "0" ]; then 
        issues_page=$(echo "$remote" | sed "s;/_git/.\+$;/_workitems;")
        handle_link "$issues_page"
        return $?
    fi

    # fail otherwise as the link is unknown.

    echo "Issues link for remote ($remote) is not known!" > /dev/stderr
    return 2
}

