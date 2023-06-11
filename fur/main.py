#!/usr/bin/python3

import os
import sys

from git import is_in_git_repo
from unified_print import print_error


def main():
    os.chdir(os.environ.get("FUR_PWD"))

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
            open_remote(function_args)
        case "commits":
            from functions.commits import commits
            commits(function_args)
        case "issues":
            from functions.issues import issues
            issues(function_args)
        case _:
            print_error(f"Unknown function: `{function}`")
            return


if __name__ == "__main__":
    main()
