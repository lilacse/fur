#!/bin/sh

# usage: process_remote_url <remote>
# cleanup/converts remote urls. 

process_remote_url()
{
    if [ "$#" -ne "1" ]; then 
        echo "Error in process_remote_url: Can only accept 1 argument, received $# instead." > /dev/stderr
        return 1
    fi

    # check if is http(s) remote 
    if echo "$1" | grep -Eq "^https?://"; then 
        # strip off `.git` ending from GitHub's origin url. 
        if echo "$1" | grep -Eq "^https://github.com/.+.git$"; then 
            converted_remote=$(echo "$1" | sed 's;\.git$;;')
            echo "$converted_remote"
            return 0
        fi

        # strip off username from Azure Devops's origin url.
        if echo "$1" | grep -Eq "^https://.+@dev.azure.com/.+/_git/.+$"; then 
            converted_remote=$(echo "$1" | sed 's;https://.\+@;https://;')
            echo "$converted_remote"
            return 0
        fi

        echo "$1"
        return 0
    fi

    # GitHub's 
    if echo "$1" | grep -Eq "^git@github.com:.+/.+\.git$"; then 
        converted_remote=$(echo "$1" | sed "s;git@github.com:;https://github.com/;")
        converted_remote=$(echo "$converted_remote" | sed "s;.git$;;")
        echo "$converted_remote"
        return 0
    fi

    # return error with no output in the case of no known conversion is available.
    return 1
}
