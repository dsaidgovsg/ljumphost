#!/usr/bin/env bash

# Get script directory: https://stackoverflow.com/a/246128
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ANSIBLE_PYTHON_INTERPRETER="$(command -v python3)" ansible-playbook --connection=local -i "${DIR}/ansible_hosts"  "${DIR}/ansible/site.yml"
