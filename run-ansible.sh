#!/usr/bin/env bash

# Get script directory: https://stackoverflow.com/a/246128
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ansible-playbook \
    --connection=local -i "${DIR}/ansible_hosts" \
    -e ansible_python_interpreter="$(command -v python3)" \
    "${DIR}/ansible/site.yml"
