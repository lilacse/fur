#!/usr/bin/python3

import sys
from git import is_in_git_repo
from unified_print import print_error


def main():
    if not is_in_git_repo():
        exit(1)

    args = sys.argv[1:]
    if len(args) == 0:
        print_error("No arguments provided!")
        exit(2)

    function = args[0]
    function_args = args[1:]

    match function:
        case "open-remote":
            from functions.open_remote import open_remote

            open_remote()


if __name__ == "__main__":
    main()
