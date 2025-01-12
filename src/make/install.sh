#!/usr/bin/env sh
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile/Containerfile before running this script.'
    exit 1
fi

install_packages() {
    if command -v apk 2>&1 > /dev/null; then
        apk update
        apk add "$@"
    elif command -v apt 2>&1 > /dev/null; then
        apt update
        apt install -y "$@"
    elif command -v dnf 2>&1 > /dev/null; then
        dnf install -y "$@"
    elif command -v pacman 2>&1 > /dev/null; then
        pacman -Sy --noconfirm "$@"
    fi
}

install_packages make
