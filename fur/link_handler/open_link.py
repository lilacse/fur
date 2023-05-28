import subprocess
from sys import platform


def open_link(link: str):
    if platform == "linux":
        # for any reason, setting stderr to subprocess.DEVNULL does not properly 
        # redirect all stderr output in this case. 
        subprocess.run(f"2>/dev/null 1>&2 xdg-open '{link}'", shell=True)
    elif platform == "win32":
        subprocess.run(["start", link], shell=True)
