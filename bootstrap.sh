#!/usr/bin/env bash
set -euo pipefail

# https://stackoverflow.com/a/246128
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

bash "${DIR}/bootstrap/python-setup.sh"
bash "${DIR}/bootstrap/ansible-setup.sh"
