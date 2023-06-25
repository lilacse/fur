import re

from git.remote.get_remote_url_https import get_remote_url_https


def get_pull_requests_url() -> str:
    base_remote_url = get_remote_url_https(None)
    pull_requests_url = __convert_to_pull_requests_url(base_remote_url)

    return pull_requests_url


def __convert_to_pull_requests_url(url: str) -> str:
    # GitHub's url
    if re.match(r"https://github.com/[^/]+/[^/]+$", url):
        url = url + "/pulls"
    # Azure Devops's url
    elif re.match(r"^https://dev.azure.com/.+/_git/.+$", url):
        url = url + "/pullrequests?_a=mine"
    else:
        raise RuntimeError(f"Conversion of url `{url}` to a commits url is not known")

    return url
