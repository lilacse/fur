import re

from git.remote.get_remote_url_https import get_remote_url_https


def get_issue_url(issue_number: str) -> str:
    base_remote_url = get_remote_url_https(None)
    issue_url = __convert_to_issue_url(base_remote_url, issue_number)

    return issue_url


def __convert_to_issue_url(url: str, issue_number: str) -> str:
    # GitHub's url
    if re.match(r"https://github.com/[^/]+/[^/]+$", url):
        url += f"/issues/{issue_number}"
    # Azure Devops's url
    elif re.match(r"^https://dev.azure.com/.+/_git/.+$", url):
        url = re.sub(r"^(https://dev.azure.com/.+)/_git/.+$",
                     r"\1/_workitems/edit/",
                     url)
        url += f"{issue_number}/"
    else:
        raise RuntimeError(f"Conversion of url `{url}` to an issue url is not known")

    return url
