import argparse

from git.remote import get_pull_request_url
from link_handler import open_link


def pull_request(args: []):
    parser = argparse.ArgumentParser(prog="pull-request | pr",
                                     description="opens the pull request's page in it's remote origin's website")
    parser.add_argument("pr_number", type=str, help="The pull request's number to open")
    parsed_args = parser.parse_args(args)

    pr_number = parsed_args.pr_number

    pull_request_url = get_pull_request_url(pr_number)
    open_link(pull_request_url)
