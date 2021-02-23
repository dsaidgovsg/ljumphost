#!/usr/bin/env bash

# Get script directory: https://stackoverflow.com/a/246128
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ALLOW_CONVENIENCE="${ALLOW_CONVENIENCE:-true}"
ALLOW_EMACS="${ALLOW_EMACS:-false}"

ansible-playbook \
    -i "localhost," \
    -c "local" \
    -e "ansible_python_interpreter=$(command -v python3)" \
    -e allow_convenience="${ALLOW_CONVENIENCE}" \
    -e allow_emacs="${ALLOW_EMACS}" \
    "${DIR}/ansible/site.yml"
