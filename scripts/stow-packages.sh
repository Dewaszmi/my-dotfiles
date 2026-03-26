#!/bin/sh

cd "$(dirname "$)")" || exit

for package in *; do
  if [ -d "$package" ]; then
    case "$package" in
      .git|scripts)
        continue
        ;;
      *)
        echo "Stowing: $package"
        stow "$package"
    esac
  fi
done
