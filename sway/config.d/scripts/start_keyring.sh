#!/bin/sh

eval $(/usr/bin/gnome-keyring-daemon --start --components=secrets,pkcs11,ssh,gpg)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
