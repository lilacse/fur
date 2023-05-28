import re
from . import get_remote_url


def get_remote_url_https() -> str:
    remote_url = get_remote_url()

    if remote_url.startswith("https://"):
        return __cleanup_https_remote_url(remote_url)

    # handle GitHub SSH urls
    if remote_url.startswith("git@github.com:"):
        repo_identifier = (
            remote_url.strip().removeprefix("git@github.com:").removesuffix(".git")
        )
        return f"https://github.com/{repo_identifier}"

    raise RuntimeError(f"Could not convert {remote_url} to a https link.")


def __cleanup_https_remote_url(url: str) -> str:
    url = url.strip()

    # remove .git suffix from GitHub urls
    if re.match(r"https:\/\/github.com\/[^/]+\/[^/]+\.git", url):
        url = url.removesuffix(".git")

    return url
