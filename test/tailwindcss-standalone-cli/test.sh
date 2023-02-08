#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "tailwindcss" tailwindcss

reportResults