import subprocess


def get_remote_url() -> str:
    git_command = subprocess.run(
        ["git", "config", "--get", "remote.origin.url"], capture_output=True, text=True
    )

    if git_command.returncode != 0:
        raise RuntimeError("Git repo does not have a remote origin URL configured.")

    return git_command.stdout


def get_remote_url_https() -> str:
    remote_url = get_remote_url()

    if remote_url.startswith("https://"):
        return remote_url

    # handle GitHub SSH urls
    if remote_url.startswith("git@github.com:"):
        repo_identifier = (
            remote_url.strip().removeprefix("git@github.com:").removesuffix(".git")
        )
        return f"https://github.com/{repo_identifier}"

    raise RuntimeError(f"Could not convert {remote_url} to a https link.")
