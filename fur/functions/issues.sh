#!/bin/sh

. "./fur/utilities/handle_link.sh"
. "./fur/utilities/process_remote_url.sh"
. "./fur/utilities/get_remote_url.sh"

# usage: fur <issues | tasks | bugs | work-items>
# opens the issues page for the repository on the remote's website.

issues()
{
    if [ "$#" -ne 0 ]; then 
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur <issues | tasks | bugs | work-items>" > /dev/stderr
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
        issues_page=$(printf "%s/issues" "$remote")
        handle_link "$issues_page"
        return $?
    fi

    # handle Azure Devops repo

    if echo "$remote" | grep -Eq "^https://dev.azure.com/"; then 
        issues_page=$(echo "$remote" | sed "s;/_git/.\+$;/_workitems;")
        handle_link "$issues_page"
        return $?
    fi

    # fail otherwise as the link is unknown.

    echo "Issues link for remote ($remote) is not known!" > /dev/stderr
    return 2
}

