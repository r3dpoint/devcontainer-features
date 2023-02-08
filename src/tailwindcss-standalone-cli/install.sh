#!/usr/bin/env bash

# References
# - https://tailwindcss.com/blog/standalone-cli
# Assumptions
# - All devcontainers are Linux
# Motivations
# - https://github.com/devcontainers/features/blob/main/src/ruby/install.sh
# - https://github.com/devcontainers/features/blob/main/src/aws-cli/install.sh

set -e

version=${VERSION:-"latest"}
if [ "${version}" != "latest" ]; then
    echo "(!) Version $version unsupported"
    exit 1
fi

kernel="$(uname)"
if [ "${kernel}" != "Linux" ]; then
    echo "(!) Kernel $kernel unsupported"
    exit 1
fi

architecture="$(uname -m)"
if [ "${architecture}" != "x86_64" ]; then
    echo "(!) Architecture $architecture unsupported"
    exit 1
fi

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            apt-get update -y
        fi
        apt-get -y install --no-install-recommends "$@"
    fi
}

export DEBIAN_FRONTEND=noninteractive

check_packages curl

file="tailwindcss-linux-x64"
curl -sLO "https://github.com/tailwindlabs/tailwindcss/releases/${version}/download/${file}"
chmod +x "${file}"
mv "${file}" "/usr/local/bin/tailwindcss"

echo "Done!"
