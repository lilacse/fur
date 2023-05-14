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


if __name__ == "__main__":
    main()
