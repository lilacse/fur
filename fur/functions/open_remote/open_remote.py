import argparse
from typing import Callable

from git import get_current_branch, get_relative_file_path
from git.remote import get_remote_url_https
from link_handler import open_link


def open_remote(args: [], handler: Callable[[str], None]):
    parser = argparse.ArgumentParser(prog="open-remote",
                                     description="opens the current repo in its remote origin's website")
    parser.add_argument("-b", "--branch", type=str, help="the branch to open, defaults to the current branch")
    parser.add_argument("-f", "--file", type=str, help="the file to open, defaults to none")

    parsed_args = parser.parse_args(args)

    branch = parsed_args.branch
    if branch is None:
        branch = get_current_branch()

    file = parsed_args.file
    file_path = None
    if file is not None:
        file_path = get_relative_file_path(file).as_posix()

    remote_url = get_remote_url_https(branch, file_path)
    handler(remote_url)
