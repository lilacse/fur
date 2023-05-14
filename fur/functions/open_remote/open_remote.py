from git.remote import get_remote_url_https
from link_handler import open_link


def open_remote():
    remote_url = get_remote_url_https()
    open_link(remote_url)
