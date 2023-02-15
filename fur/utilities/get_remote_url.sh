#!/bin/sh

# usage: get_remote_url 
# prints the remote url of the repo and return 0 if available, return 2 if not. 

get_remote_url()
{
    if [ "$#" -ne "0" ]; then 
        echo "Error in get_remote_url: Can only accept 0 arguments, received $# instead." > /dev/stderr
        return 1
    fi

    remote="$(git -C "$FUR_PWD" config --get remote.origin.url)"

    if [ "$?" -eq "1" ]; then
        echo "Origin URL not set for this repository." > /dev/stderr
        return 2
    fi

    echo "$remote"
    return 0
}
