#!/bin/sh

. "./utilities/handle_link.sh"
. "./utilities/process_remote_url.sh"
. "./utilities/get_remote_url.sh"

# usage: fur <create-pull-request | cpr> [--from source_repo] [--to target_repo]
# opens the create pull request page for the repository on the remote's website.

create_pull_request()
{
    options=$(getopt -a -u --longoptions "from:,to:" -- "" "$@")

    if [ "$?" -ne "0" ]; then 
        echo
        echo "Invalid arguments."
        echo "usage: fur <create-pull-request | cpr> [--from source_repo] [--to target_repo]"
        return 1
    fi

    set -- $options

    while true; do 
        if [ "$1" = "--from" ]; then 
            from_repo="$2"
            shift 2
        elif [ "$1" = "--to" ]; then 
            to_repo="$2"
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

    # sets from_repo to current repo by default

    if [ -z "$from_repo" ]; then 
        from_repo=$(git -C "$FUR_PWD" symbolic-ref --short HEAD)
    fi

    # handle GitHub repo

    echo "$remote" | grep -Eq "^https://github.com/.+$"

    if [ "$?" -eq "0" ]; then 
        create_pr_page=$(printf "%s/compare/%s...%s" "$remote" "$to_repo" "$from_repo")
        handle_link "$create_pr_page"
        return $?
    fi

    # handle Azure Devops repo

    echo "$remote" | grep -Eq "^https://dev.azure.com/.+/_git/.+$" 

    if [ "$?" -eq "0" ]; then 
        create_pr_page=$(printf "%s/pullrequestcreate?sourceRef=%s&targetRef=%s" "$remote" "$from_repo" "$to_repo")
        handle_link "$create_pr_page"
        return $?
    fi

    # fail otherwise as the link is unknown.

    echo "Create pull requests link for remote ($remote) is not known!"
    return 2
}
