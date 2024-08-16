import argparse

from git import get_current_branch
from git.remote import get_create_pull_request_url
from link_handler import open_link


def create_pull_request(args: []):
    parser = argparse.ArgumentParser(prog="create-pull-request | cpr",
                                     description="opens the current repo's create pull request page in its remote "
                                                 "origin's website")
    parser.add_argument("-f", "--from", dest="from_branch", type=str, help="the branch to merge from, defaults to the "
                                                                           "current branch")
    parser.add_argument("-t", "--to", dest="to_branch", type=str, help="the branch to merge to")

    parsed_args = parser.parse_args(args)

    from_branch = parsed_args.from_branch
    to_branch = parsed_args.to_branch

    if from_branch is None:
        from_branch = get_current_branch()

    create_pull_request_url = get_create_pull_request_url(from_branch, to_branch)
    open_link(create_pull_request_url)
