#!/bin/sh

# usage: fur recommit [git commit options]
# soft-resets the last commit and make another commit including the currently staged changes.

recommit()
{
    git -C "$FUR_PWD" reset --soft head~1

    # aborts if the reset fail for any reason.

    if [ "$?" -ne "0" ]; then 
        echo
        echo "Failed to reset the last commit. See output above for more information."
        return 1
    fi

    git -C "$FUR_PWD" commit "$@"
}
