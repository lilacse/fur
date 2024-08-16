import re

from git.remote.get_remote_url_https import get_remote_url_https


def get_commit_url(commit_hash: str) -> str:
    base_remote_url = get_remote_url_https(None)
    commit_url = __convert_to_commit_url(base_remote_url, commit_hash)

    return commit_url


def __convert_to_commit_url(url: str, commit_hash: str) -> str:
    # GitHub's url
    if re.match(r"https://github.com/[^/]+/[^/]+$", url):
        url += f"/commit/{commit_hash}"
    # Azure Devops's url
    elif re.match(r"^https://dev.azure.com/.+/_git/.+$", url):
        url += f"/commit/{commit_hash}"
    else:
        raise RuntimeError(f"Conversion of url `{url}` to a commit url is not known")

    return url
