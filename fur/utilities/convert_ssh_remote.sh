#!/bin/sh

# usage: convert_ssh_remote [remote]
# converts an SSH remote url into a http(s) remote url if possible. http(s) links will be left as is. 

convert_ssh_remote()
{
    if [ "$#" -ne "1" ]; then 
        echo "Error in convert_ssh_remote: Can only accept 1 argument, received $# instead."
        return 1
    fi

    # check if is http(s) remote 
    
    echo "$1" | grep -Eq "^https?://"

    if [ "$?" -eq "0" ]; then 
        echo "$1"
        return 0
    fi

    # GitHub's 

    echo "$1" | grep -Eq "^git@github.com:.+/.+\.git$"

    if [ "$?" -eq "0" ]; then 
        converted_remote=$(echo "$1" | sed "s;git@github.com:;https://github.com/;")
        echo "$converted_remote"
        return 0
    fi

    # return error with no output in the case of no known conversion is available.

    return 1
}
