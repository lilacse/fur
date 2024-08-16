import subprocess


def get_commit_hash(commit_ref: str) -> str | None:
    git_command = subprocess.run(
        ["git", "rev-parse", commit_ref], capture_output=True, text=True
    )
    if git_command.returncode == 0:
        return git_command.stdout.strip()
