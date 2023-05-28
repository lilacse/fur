import subprocess


def get_remote_url() -> str:
    git_command = subprocess.run(
        ["git", "config", "--get", "remote.origin.url"], capture_output=True, text=True
    )

    if git_command.returncode != 0:
        raise RuntimeError("Git repo does not have a remote origin URL configured.")

    return git_command.stdout
