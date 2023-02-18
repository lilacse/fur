#!/bin/sh

. "./utilities/handle_link.sh"
. "./utilities/process_remote_url.sh"
. "./utilities/get_remote_url.sh"
. "./utilities/url_encode.sh"

# usage: fur <commits> [--branch branch_override]
# opens the commits page for the specified branch of the repository on the remote's website.

commits()
{
    options=$(getopt -a -u --longoptions "branch:" -- "" "$@")

    if ! options=$(getopt -a -u --longoptions "branch:" -- "" "$@"); then 
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur commits [--branch branch_override]" > /dev/stderr
        return 1
    fi

    set -- $options

    while true; do 
        if [ "$1" = "--branch" ]; then 
            branch="$2"
            shift 2
        elif [ "$1" = "--" ]; then 
            shift
            break
        fi
    done

    if ! remote="$(get_remote_url)" ; then
        return 3
    fi

    # cleanup/convert origin url beforehand.

    remote=$(process_remote_url "$remote")

    # add branch to url

    if [ -z "$branch" ]; then 
        branch=$(git -C "$FUR_PWD" symbolic-ref --short HEAD)
    fi

    # handle GitHub repo

    if echo "$remote" | grep -Eq "^https://github.com/.+$"; then 
        commits_page=$(printf "%s/commits/%s" "$remote" "$branch")
        handle_link "$commits_page"
        return $?
    fi

    # handle Azure Devops repo

    if echo "$remote" | grep -Eq "^https://dev.azure.com/"; then 
        encoded_branch=$(url_encode "$branch")
        commits_page=$(printf "%s/commits?itemVersion=GB%s" "$remote" "$encoded_branch")
        handle_link "$commits_page"
        return $?
    fi

    # fail otherwise as the link is unknown.

    echo "Commits link for remote ($remote) is not known!" > /dev/stderr
    return 2
}
