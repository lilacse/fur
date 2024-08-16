import argparse

from git.remote import get_branches_url
from link_handler import open_link


def branches(args: []):
    parser = argparse.ArgumentParser(prog="branches",
                                     description="opens the current repo's branches page in its remote origin's "
                                                 "website")
    parser.parse_args(args)

    branches_url = get_branches_url()
    open_link(branches_url)
