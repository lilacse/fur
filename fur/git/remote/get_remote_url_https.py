import re
import urllib.parse

from git.remote.get_remote_url import get_remote_url


def get_remote_url_https(branch: str = None, file_path: str = None) -> str:
    remote_url = get_remote_url()
    remote_url = __convert_to_https_url(remote_url)
    remote_url = __cleanup_https_remote_url(remote_url)

    if branch is not None:
        remote_url = __add_branch_to_url(remote_url, branch)
    if file_path is not None:
        remote_url = __add_file_path_to_url(remote_url, file_path)

    return remote_url


def __convert_to_https_url(url: str) -> str:
    if url.startswith("https://"):
        return url

    # handle GitHub SSH urls
    if url.startswith("git@github.com:"):
        repo_identifier = (
            url.strip().removeprefix("git@github.com:").removesuffix(".git")
        )
        return f"https://github.com/{repo_identifier}"

    # handle Azure DevOps SSH urls
    if url.startswith("git@ssh.dev.azure.com:v3"):
        repo_identifier = url.strip().removeprefix("git@ssh.dev.azure.com:v3/")
        path_components = repo_identifier.split("/")
        return f"https://dev.azure.com/{path_components[0]}/{path_components[1]}/_git/{path_components[2]}"

    raise RuntimeError(f"Could not convert {url} to a https link.")


def __cleanup_https_remote_url(url: str) -> str:
    url = url.strip()

    # remove .git suffix from GitHub urls
    if re.match(r"^https://github.com/[^/]+/[^/]+\.git", url):
        url = url.removesuffix(".git")

    # remove username from Azure Devops urls
    elif re.match(r"^https://.+@dev.azure.com/.+/_git/.+$", url):
        url = re.sub(r"^https://.+@", "https://", url)

    return url


def __add_branch_to_url(url: str, branch: str) -> str:
    # GitHub's url
    if re.match(r"^https://github.com/[^/]+/[^/]+$", url):
        url = url + f"/tree/{branch}"

    # Azure Devops's url
    elif re.match(r"^https://dev.azure.com/.+/_git/.+$", url):
        encoded_branch = urllib.parse.quote_plus(branch)
        url = url + f"?version=GB{encoded_branch}"

    return url


def __add_file_path_to_url(url: str, file_path: str) -> str:
    # GitHub's url
    if re.match(r"^https://github.com/[^/]+/[^/]+/.+$", url):
        encoded_file_path = urllib.parse.quote_plus(file_path)
        url = url + f"/{encoded_file_path}"

    # Azure Devops's url
    elif re.match(r"^https://dev.azure.com/.+/_git/.+$", url):
        encoded_file_path = urllib.parse.quote_plus(f"/{file_path}")
        url = url + f"&path={encoded_file_path}"

    return url
