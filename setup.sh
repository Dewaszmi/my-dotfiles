#!/bin/sh

# one .sh to rule them all

echo "Installing additional utilities."
./scripts/install-utils.sh

echo "Stowing packages."
./scripts/stow-packages.sh

echo "Running theme selector."
./scripts/theme-picker.sh
