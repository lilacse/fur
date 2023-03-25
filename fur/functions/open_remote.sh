#!/bin/sh

. "./fur/utilities/handle_link.sh"
. "./fur/utilities/process_remote_url.sh"
. "./fur/utilities/url_encode.sh"
. "./fur/utilities/get_remote_url.sh"

# usage: fur open-remote [--branch branch_override]
# opens the repository's remote url.

open_remote()
{
    if ! options=$(getopt -a -u --longoptions "branch:" -- "b:" "$@"); then 
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur open-remote [--branch | -b branch_override]" > /dev/stderr
        return 1
    fi

    # shellcheck disable=SC2086
    set -- $options

    while true; do 
        if [ "$1" = "--branch" ] || [ "$1" = "-b" ]; then 
            branch="$2"
            shift 2
        elif [ "$1" = "--" ]; then 
            shift
            break
        fi
    done

    # shellcheck disable=SC2119
    if ! remote="$(get_remote_url)"; then
        return 3
    fi

    # abort if conversion failed, since the url is not handle-able. 
    if ! remote=$(process_remote_url "$remote"); then 
        echo "Handling for origin url ($remote) is unknown." > /dev/stderr
        return 2
    fi

    # add branch to url
    if [ -z "$branch" ]; then 
        branch=$(git -C "$FUR_PWD" symbolic-ref --short HEAD)
    fi

    # GitHub's url with branch.
    if echo "$remote" | grep -Eq "^https://github.com/"; then 
        remote="$(printf "%s/tree/%s" "$remote" "$branch")"
    fi

    # Azure Devops' url with branch
    if echo "$remote" | grep -Eq "^https://dev.azure.com/"; then 
        encoded_branch=$(url_encode "$branch")
        remote="$(printf "%s?version=GB%s" "$remote" "$encoded_branch")"
    fi
    
    handle_link "$remote"
    return $?
}
