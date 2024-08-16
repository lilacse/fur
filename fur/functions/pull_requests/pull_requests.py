import argparse

from git.remote import get_pull_requests_url
from link_handler import open_link


def pull_requests(args: []):
    parser = argparse.ArgumentParser(prog="pull-requests | prs",
                                     description="opens the current repo's pull requests page in its remote origin's "
                                                 "website")
    parser.parse_args(args)

    pull_requests_url = get_pull_requests_url()
    open_link(pull_requests_url)
