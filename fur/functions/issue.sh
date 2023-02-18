#!/bin/sh

. "./fur/utilities/handle_link.sh"
. "./fur/utilities/process_remote_url.sh"
. "./fur/utilities/get_remote_url.sh"

# usage: fur <issue | task | bug | work-item> <issue_number>
# opens the issue page for the given issue number for the repository on the remote's website.

issues()
{
    if [ "$#" -ne 1 ]; then 
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur <issue | task | bug | work-item> <issue_number>" > /dev/stderr
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
        issue_page=$(printf "%s/issues/%s" "$remote" "$1")
        handle_link "$issue_page"
        return $?
    fi

    # handle Azure Devops repo

    if echo "$remote" | grep -Eq "^https://dev.azure.com/"; then 
        issue_page=$(echo "$remote" | sed "s;/_git/.\+$;/_workitems/edit/$1/;")
        handle_link "$issue_page"
        return $?
    fi

    # fail otherwise as the link is unknown.

    echo "Issue link for remote ($remote) is not known!" > /dev/stderr
    return 2
}

