#!/bin/bash

# Adds support for Apple Silicon brew directory
export PATH="$PATH:/opt/homebrew/bin"

if which swiftlint >/dev/null; then
  swiftlint autocorrect
  swiftlint --config "${SRCROOT}/tools/SwiftLint/.swiftlint.yaml" --strict
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
