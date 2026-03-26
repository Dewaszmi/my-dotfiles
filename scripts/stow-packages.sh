#!/bin/sh

cd "$(dirname "$)")" || exit

for package in *; do
  if [ -d "$package" ]; then
    if [ "$package" = ".git" ]; then
      continue
    fi
    echo "Stowing: $package"
    stow "$package"
  fi
done
