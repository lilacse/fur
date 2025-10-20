import argparse
from typing import Callable

from git.remote import get_issue_url
from link_handler import open_link


def issue(args: [], handler: Callable[[str], None]):
    parser = argparse.ArgumentParser(prog="issue | task | bug | ticket | work-item",
                                     description="opens the issue's page in its remote origin's website")
    parser.add_argument("issue_number", type=str, help="The issue number to open")
    parsed_args = parser.parse_args(args)

    issue_number = parsed_args.issue_number

    issue_url = get_issue_url(issue_number)
    handler(issue_url)
