import re

from git.remote.get_remote_url_https import get_remote_url_https


def get_commits_url(branch: str = None) -> str:
    base_remote_url = get_remote_url_https(branch)
    commits_url = __convert_to_commits_url(base_remote_url)

    return commits_url


def __convert_to_commits_url(url: str) -> str:
    # GitHub's url with branch
    if re.match(r"https://github.com/[^/]+/[^/]+/tree/.+$", url):
        url = re.sub(r"^https://github.com/([^/]+)/([^/]+)/tree/",
                     r"https://github.com/\1/\2/commits/",
                     url)
    else:
        raise RuntimeError(f"Conversion of url `{url}` to a commits url is not known")

    return url
