#!/usr/bin/env bash

# References
# - https://tailwindcss.com/blog/standalone-cli
# Assumptions
# - All devcontainers are Linux
# Motivations
# - https://github.com/devcontainers/features/blob/main/src/ruby/install.sh

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

file="tailwindcss-linux-x64"
curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/${version}/download/${file}
chmod +x ${file}
mv ${file} /usr/local/bin/tailwindcss

echo "Done!"