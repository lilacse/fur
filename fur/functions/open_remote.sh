#!/bin/sh

. "./utilities/handle_link.sh"
. "./utilities/process_remote_url.sh"
. "./utilities/url_encode.sh"
. "./utilities/get_remote_url.sh"

# usage: fur open-remote [--branch branch_override]
# opens the repository's remote url.

open_remote()
{
    options=$(getopt -a -u --longoptions "branch:" -- "" "$@")

    if [ "$?" -ne "0" ]; then 
        echo "Invalid arguments." > /dev/stderr
        echo "usage: fur open-remote [--branch branch_override]" > /dev/stderr
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

    remote="$(get_remote_url)"

    if [ "$?" -ne "0" ]; then
        return 3
    fi

    # cleanup/convert origin url beforehand.

    remote=$(process_remote_url "$remote")

    if [ "$?" -ne "0" ]; then 

        # conversion failed, hence the url is not handle-able. 

        echo "Handling for origin url ($remote) is unknown." > /dev/stderr
        return 2
    fi

    # add branch to url

    if [ -z "$branch" ]; then 
        branch=$(git -C "$FUR_PWD" symbolic-ref --short HEAD)
    fi

    # GitHub's url with branch.

    echo "$remote" | grep -Eq "^https://github.com/"

    if [ "$?" -eq "0" ]; then 
        remote="$(printf "%s/tree/%s" "$remote" "$branch")"
    fi

    # Azure Devops' url with branch

    echo "$remote" | grep -Eq "^https://dev.azure.com/"

    if [ "$?" -eq "0" ]; then 
        encoded_branch=$(url_encode "$branch")
        remote="$(printf "%s?version=GB%s" "$remote" "$encoded_branch")"
    fi
    
    handle_link "$remote"
    return $?
}
