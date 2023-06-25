import re

from git.remote.get_remote_url_https import get_remote_url_https


def get_pull_request_url(pr_number: str) -> str:
    base_remote_url = get_remote_url_https(None)
    pull_request_url = __convert_to_pull_request_url(base_remote_url, pr_number)

    return pull_request_url


def __convert_to_pull_request_url(url: str, pr_number: str) -> str:
    # GitHub's url
    if re.match(r"https://github.com/[^/]+/[^/]+$", url):
        url += f"/pull/{pr_number}"
    # Azure Devops's url
    elif re.match(r"^https://dev.azure.com/.+/_git/.+$", url):
        url += f"/pullrequest/{pr_number}"
    else:
        raise RuntimeError(f"Conversion of url `{url}` to a commits url is not known")

    return url
