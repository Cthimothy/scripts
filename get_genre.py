import os
from pathlib import Path

dirs = os.listdir(".")
for f in dirs:
    mp3_pths = [pth for pth in Path.cwd(f).iterdir()
        if pth.suffix == '.mp3']

print mp3_pths
