import argparse

from git import get_current_branch
from git.remote import get_remote_url_https
from link_handler import open_link


def open_remote(args: []):
    parser = argparse.ArgumentParser(prog="open-remote",
                                     description="opens the current repo in its remote origin's website")
    parser.add_argument("-b", "--branch", type=str, help="the branch to open, defaults to the current branch")

    parsed_args = parser.parse_args(args)

    branch = parsed_args.branch
    if branch is None:
        branch = get_current_branch()

    remote_url = get_remote_url_https(branch)
    open_link(remote_url)
