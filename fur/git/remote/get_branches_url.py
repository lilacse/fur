import re

from git.remote.get_remote_url_https import get_remote_url_https


def get_branches_url() -> str:
    base_remote_url = get_remote_url_https(None)
    branches_url = __convert_to_branches_url(base_remote_url)

    return branches_url


def __convert_to_branches_url(url: str) -> str:
    # GitHub's url
    if re.match(r"https://github.com/[^/]+/[^/]+$", url):
        url = url + "/branches"
    # Azure Devops's url
    elif re.match(r"^https://dev.azure.com/.+/_git/.+$", url):
        url = url + "/branches"
    else:
        raise RuntimeError(f"Conversion of url `{url}` to an issues url is not known")

    return url
