#!/usr/bin/env bash
set -euo pipefail

# Global variables, can override if preferred
ANSIBLE_VERSION=${ANSIBLE_VERSION:-2.7.18}

pip install "ansible==${ANSIBLE_VERSION}"

# Test the install python works
ansible --version
