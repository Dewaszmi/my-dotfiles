#!/bin/sh

# just automates stowing

cd "$(dirname "$)")" || exit

for package in *; do
  if [ -d "$package" ]; then
    case "$package" in
      .git|scripts)
        continue
        ;;
      *)
        stow "$package"
    esac
  fi
done
