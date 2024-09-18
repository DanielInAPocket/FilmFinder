#!/bin/sh
#set -eux

# Checking if Homebrew is installed
if ! which brew >/dev/null; then
  echo "Please install Homebrew first! https://brew.sh"
  exit 1
fi

# Check if script is being run from the project root directory.
if [ ! -d "FilmFinder.xcodeproj" ]; then
    echo "Script should be executed from the project root directory, the one containing 'FilmFinder.xcodeproj'!"
    exit 1
fi

cd Scripts

./install_swiftgen.sh
./install_swiftlint.sh
