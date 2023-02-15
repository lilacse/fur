#!/bin/sh

# usage: url_encode <string>
# percent-encodes a string.

url_encode()
{
    if [ "$#" -ne "1" ]; then 
        echo "Error in url_encode: Can only accept 1 argument, received $# instead."
        return 1
    fi

    echo "$1" | tr -d "\n" | xxd -p | sed 's/../%&/g'

    return $?
}
