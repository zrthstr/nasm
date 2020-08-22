#!/usr/bin/env python3

import sys
from pythonping import ping


def main():
    if not len(sys.argv) == 2:
        print(f"Usage: {sys.argv[0]} [destination-host]")
        sys.exit()

    ping(sys.argv[1], verbose=True)


if __name__ == "__main__":
    main()

