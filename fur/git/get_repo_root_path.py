import subprocess

from pathlib import Path


def get_repo_root_path() -> Path:
    git_command = subprocess.run(
        ["git", "rev-parse", "--git-dir"], capture_output=True, text=True
    )
    if git_command.returncode == 0:
        git_dir_path = Path(git_command.stdout.strip())
        return git_dir_path.parent
