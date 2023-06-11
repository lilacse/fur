import re

from git.remote.get_remote_url_https import get_remote_url_https


def get_issues_url(branch: str = None) -> str:
    base_remote_url = get_remote_url_https(branch)
    issues_url = __convert_to_issues_url(base_remote_url)

    return issues_url


def __convert_to_issues_url(url: str) -> str:
    # GitHub's url with branch
    if re.match(r"https://github.com/[^/]+/[^/]+$", url):
        url = url + "/issues"
    else:
        raise RuntimeError(f"Conversion of url `{url}` to a commits url is not known")

    return url
