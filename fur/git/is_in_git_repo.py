import subprocess


def is_in_git_repo() -> bool:
    git_command = subprocess.run(["git", "rev-parse"])
    return git_command.returncode == 0
