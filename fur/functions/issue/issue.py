import argparse

from git.remote import get_issue_url
from link_handler import open_link


def issue(args: []):
    parser = argparse.ArgumentParser(prog="issue | task | bug | ticket | work-item",
                                     description="opens the issue's page in it's remote origin's website")
    parser.add_argument("issue_number", type=str, help="The issue's number to open")
    parsed_args = parser.parse_args(args)

    issue_number = parsed_args.issue_number

    issue_url = get_issue_url(issue_number)
    open_link(issue_url)
