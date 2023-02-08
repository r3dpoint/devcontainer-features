#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "version" tailwindcss --help | awk '/^tailwindcss v/' | grep "tailwindcss v3.2.5"

# Report result
reportResults
