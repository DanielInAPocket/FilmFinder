#!/bin/sh
#set -eux

if which swiftgen >/dev/null; then
  echo "SwiftGen already installed. Upgrading..."
  brew upgrade swiftgen
else
  echo "SwiftGen not found. Installing..."
  brew install swiftgen
fi