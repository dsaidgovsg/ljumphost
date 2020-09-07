#!/usr/bin/env bash
set -euo pipefail

# Global variables, can override if preferred
ANSIBLE_VERSION=${ANSIBLE_VERSION:-2.7.18}

# This script installs purely to user, but does require certain prequisites that
# need root access

if ! command -v sudo > /dev/null; then
    echo "Need sudo to check and install prerequisites."
    exit 1
fi

# Ensure python3 is installed
sudo dnf install -y python3 python3-pip

# cryptography is an unspecified requirement for paramiko (ansible)
# thus needing to be explicitly specified here for installation
echo "Install ansible via pip..."
sudo bash -c "umask 022 &&
    python3 -m pip install \
    \"ansible==${ANSIBLE_VERSION}\" \
    \"cryptography>=2.5\""

# Test the install python works
ansible --version

echo "Install python3-dnf to allow Ansible to run dnf..."
sudo dnf install -y python3-dnf
