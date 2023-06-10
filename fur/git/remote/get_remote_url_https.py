import re

from git.remote.get_remote_url import get_remote_url


def get_remote_url_https(branch: str = None) -> str:
    remote_url = get_remote_url()

    # handle GitHub SSH urls
    if remote_url.startswith("git@github.com:"):
        repo_identifier = (
            remote_url.strip().removeprefix("git@github.com:").removesuffix(".git")
        )
        remote_url = f"https://github.com/{repo_identifier}"

    if remote_url.startswith("https://"):
        remote_url = __cleanup_https_remote_url(remote_url)
    else:
        raise RuntimeError(f"Could not convert {remote_url} to a https link.")

    if branch is not None:
        remote_url = __add_branch_to_url(remote_url, branch)

    return remote_url


def __cleanup_https_remote_url(url: str) -> str:
    url = url.strip()

    # remove .git suffix from GitHub urls
    if re.match(r"https://github.com/[^/]+/[^/]+\.git", url):
        url = url.removesuffix(".git")

    return url


def __add_branch_to_url(url: str, branch: str) -> str:
    # GitHub's url
    if re.match(r"https://github.com/[^/]+/[^/]+$", url):
        url = url + f"/tree/{branch}"

    return url
