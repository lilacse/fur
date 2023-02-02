#!/bin/sh

. "./utilities/handle_link.sh"

# usage: fur open-remote
# opens the repository's remote url.

open_remote()
{
    if [ "$#" -ne 0 ]; then 
        echo "Invalid arguments."
        echo "usage: fur open-remote"
        return 1
    fi

    remote="$(git -C "$FUR_PWD" config --get remote.origin.url)"

    if [ "$?" -eq "1" ]; then
        echo "Origin URL not set for this repository."
        return 3
    fi

    # handle link directly if it is a http/https link

    echo "$remote" | grep -Eq "^https?://"

    if [ "$?" -eq "0" ]; then 
    
        # strip off username from Azure Devops's origin url.

        echo "$remote" | grep -Eq "^https://.+@dev.azure.com/.+/_git/.+$" 

        if [ "$?" -eq "0" ]; then 
            remote=$(echo "$remote" | sed 's;https://.\+@;https://;')
        fi
        
        handle_link "$remote"
        return $?
    fi 

    # if is GitHub's ssh remote origin url, convert it to a GitHub repo url. 

    echo "$remote" | grep -Eq "^git@github.com:.+/.+\.git$"

    if [ "$?" -eq "0" ]; then 
        remote=$(echo "$remote" | sed "s;git@github.com:;https://github.com/;")
        handle_link "$remote"
        return $?
    fi

    # fail otherwise

    echo "Origin url ($remote) cannot be opened."
    return 2
}
