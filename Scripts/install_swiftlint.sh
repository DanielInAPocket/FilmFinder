#!/bin/sh
#set -eux

if which swiftlint >/dev/null; then
  echo "SwiftLint already installed. Upgrading..."
  brew upgrade swiftlint
else
  echo "SwiftLint not found. Installing..."
  brew install swiftlint
fi