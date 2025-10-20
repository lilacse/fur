import argparse
from typing import Callable

from git import get_commit_hash
from git.remote import get_commit_url
from link_handler import open_link
from unified_print import print_error


def commit(args: [], handler: Callable[[str], None]):
    parser = argparse.ArgumentParser(prog="commit",
                                     description="opens the commit's page in its remote origin's website")
    parser.add_argument("commit_ref", type=str, help="The commit to open. Accepts a value usable with `git rev-parse`.")
    parsed_args = parser.parse_args(args)

    commit_hash = get_commit_hash(parsed_args.commit_ref)
    if commit_hash is None:
        print_error(f"Unable to resolve commit hash for `{parsed_args.commit_ref}`")
        exit(2)

    commit_url = get_commit_url(commit_hash)
    handler(commit_url)
