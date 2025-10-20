import argparse
from typing import Callable

from git.remote import get_branches_url
from link_handler import open_link


def branches(args: [], handler: Callable[[str], None]):
    parser = argparse.ArgumentParser(prog="branches",
                                     description="opens the current repo's branches page in its remote origin's "
                                                 "website")
    parser.parse_args(args)

    branches_url = get_branches_url()
    handler(branches_url)
