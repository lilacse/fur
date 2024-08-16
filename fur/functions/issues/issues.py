import argparse

from git.remote import get_issues_url
from link_handler import open_link


def issues(args: []):
    parser = argparse.ArgumentParser(prog="issues | tasks | bugs | tickets | work-items",
                                     description="opens the current repo's issues page in its remote origin's website")
    parser.parse_args(args)

    issues_url = get_issues_url()
    open_link(issues_url)
