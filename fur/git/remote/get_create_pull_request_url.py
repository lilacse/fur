import re

from git.remote.get_remote_url_https import get_remote_url_https


def get_create_pull_request_url(from_branch: str = None, to_branch: str = None) -> str:
    base_remote_url = get_remote_url_https(None)
    create_pull_request_url = __convert_to_create_pull_request_url(base_remote_url, from_branch, to_branch)

    return create_pull_request_url


def __convert_to_create_pull_request_url(url: str, from_branch: str = None, to_branch: str = None) -> str:
    # GitHub's url
    if re.match(r"https://github.com/[^/]+/[^/]+$", url):
        url += f"/compare/{to_branch}...{from_branch}"
    # Azure Devops's url
    elif re.match(r"^https://dev.azure.com/.+/_git/.+$", url):
        url += f"/pullrequestcreate?sourceRef={from_branch}&targetRef={to_branch}"
    else:
        raise RuntimeError(f"Conversion of url `{url}` to a create pull request url is not known")

    return url
