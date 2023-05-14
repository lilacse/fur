from sys import platform
import subprocess 

def open_link(link: str):
    if platform == 'linux':
        subprocess.run(['xdg-open', link])
    elif platform == 'win32':
        subprocess.run(['start', link], shell=True)
