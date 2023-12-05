from pathlib import Path

from .get_repo_root_path import get_repo_root_path


def get_relative_file_path(file: str) -> Path:
    repo_root_path = get_repo_root_path()
    file_path = Path(file).resolve()
    return file_path.relative_to(repo_root_path)
