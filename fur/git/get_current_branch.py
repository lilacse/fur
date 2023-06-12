import subprocess


def get_current_branch():
    git_command = subprocess.run(
        ["git", "symbolic-ref", "--short", "HEAD"], capture_output=True, text=True
    )
    if git_command.returncode == 0:
        return git_command.stdout.strip()
