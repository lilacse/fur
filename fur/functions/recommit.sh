#!/bin/sh

# usage: fur recommit [git commit options]
# soft-resets the last commit and make another commit including the currently staged changes.

recommit()
{
    # aborts if the reset fail for any reason.
    if ! git -C "$FUR_PWD" reset --soft HEAD~1; then 
        echo "Failed to reset the last commit. See output above for more information." > /dev/stderr
        return 1
    fi

    git -C "$FUR_PWD" commit "$@"
}
