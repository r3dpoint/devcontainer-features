#!/usr/bin/env bash

# References
# - https://tailwindcss.com/blog/standalone-cli
# Assumptions
# - All devcontainers are Linux
# Motivations
# - https://github.com/devcontainers/features/blob/main/src/ruby/install.sh
# - https://github.com/devcontainers/features/blob/main/src/aws-cli/install.sh

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

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

# https://github.com/tailwindlabs/tailwindcss/releases
architecture="$(uname -m)"
if [ "${architecture}" == "amd64" ]; then
    file="tailwindcss-linux-x64"
elif [ "${architecture}" == "x86_64" ]; then
    file="tailwindcss-linux-x64"
elif [ "${architecture}" == "arm64" ]; then
    file="tailwindcss-linux-arm64"
elif [ "${architecture}" == "aarch64" ]; then
    file="tailwindcss-linux-arm64"
else
    echo "(!) Architecture $architecture unsupported"
    exit 1
fi

curl -sLO "https://github.com/tailwindlabs/tailwindcss/releases/${version}/download/${file}"
chmod +x "${file}"
mv "${file}" "/usr/local/bin/tailwindcss"

echo "Done!"
