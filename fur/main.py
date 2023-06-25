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
        case "issue" | "task" | "bug" | "ticket" | "work-item":
            from functions.issue import issue
            issue(function_args)
        case "pull-requests" | "prs":
            from functions.pull_requests import pull_requests
            pull_requests(function_args)
        case "pull-request" | "pr":
            from functions.pull_request import pull_request
            pull_request(function_args)
        case "create-pull-request" | "cpr":
            from functions.create_pull_request import create_pull_request
            create_pull_request(function_args)
        case _:
            print_error(f"Unknown function: `{function}`")
            return


if __name__ == "__main__":
    main()
