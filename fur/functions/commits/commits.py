import argparse

from git import get_current_branch
from git.remote import get_commits_url
from link_handler import open_link


def commits(args: []):
    parser = argparse.ArgumentParser(prog="open-remote",
                                     description="opens the current repo's commit page in it's remote origin's website")
    parser.add_argument("-b", "--branch", type=str, help="the branch to open, defaults to the current branch")

    parsed_args = parser.parse_args(args)

    branch = parsed_args.branch
    if branch is None:
        branch = get_current_branch()

    commits_url = get_commits_url(branch)
    open_link(commits_url)
