#!/usr/bin/zsh

cd "$(dirname "$)")"

for package in *; do
  if [ -d "$package" ]; then
    if [ "$package" = ".git" ]; then
      continue
    fi
    echo "Stowing: $package
    stow "$package"
  fi
done
