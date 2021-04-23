import os
import sys
from pathlib import Path


def list_dir(folder):
    """Return all files and subdirectories from folder"""
    for root, dirs, files in os.walk(folder, topdown=False):
        for name in files:
            yield os.path.join(root, name)
        for name in dirs:
            yield os.path.join(root, name)


def save_files(folder, output):
    """Save the list of files from folder to output"""
    with open(output, "w") as f:
        f.writelines([line + "\n" for line in list_dir(folder)])


def remove_files(input):
    """Remove files and empty directories listed in input"""
    with open(input, "r") as f:
        for line in f:
            p = Path(line.strip())
            if p.is_file():
                print(f"Delete file {p}")
                p.unlink()
            elif p.is_dir():
                print(f"Delete dir {p}")
                try:
                    p.rmdir()
                except OSError:
                    # Skip directory if not empty
                    pass


def main():
    if len(sys.argv) < 2:
        print(f"usage: {sys.argv[0]} save <root> <filename>")
        print(f"usage: {sys.argv[0]} delete <filename>")
        sys.exit(1)
    cmd = sys.argv[1]
    if cmd == "save":
        save_files(sys.argv[2], sys.argv[3])
    elif cmd == "delete":
        remove_files(sys.argv[2])


if __name__ == "__main__":
    main()
