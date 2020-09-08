#!/usr/bin/env bash
set -euo pipefail

# This script installs purely to user, but does require certain prequisites that
# need root access

if command -v pyenv > /dev/null; then
    echo "pyenv already installed, nothing to do..."
    exit 0
fi

if ! command -v sudo > /dev/null; then
    echo "Need sudo to check and install prerequisites."
    exit 1
fi

# Global variables, can override if preferred
PYTHON_VERSION=${PYTHON_VERSION:-3.8.5}

# Set up prerequisites
echo "Checking and installing prerequisites for pyenv..."
sudo apt-get update
sudo apt-get install -y --no-install-recommends curl ca-certificates git

# Installs to PYENV_ROOT="${HOME}/.pyenv" by default
curl https://pyenv.run | bash

cat <<"EOT" >> "${HOME}/.bashrc"
export PATH="${HOME}/.pyenv/bin:${PATH}"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOT

# For some reason, the following directories must be manually created by root
# first because the actual user won't have rights to create them
# mkdir -p "${PYENV_ROOT}/shims"
# mkdir -p "${PYENV_ROOT}/versions"

# Need to temporarily disable u flag
set +u

# shellcheck source=/dev/null
source "${HOME}/.bashrc"
set -u

# Set the global version
echo "Checking and installing prerequisites for python build..."
sudo apt-get install -y --no-install-recommends \
    wget \
    build-essential llvm \
    libssl-dev python-openssl \
    tk-dev libffi-dev \
    libreadline-dev libncurses5-dev libncursesw5-dev \
    libsqlite3-dev \
    xz-utils liblzma-dev zlib1g-dev libbz2-dev

# Get rid of the installed python2 symbolic link due to python-openssl to prevent confusion
rm -f /usr/bin/python2
pyenv install "${PYTHON_VERSION}"
pyenv global "${PYTHON_VERSION}"

# Test the install python works
python --version

# Replace current shell
exec "${SHELL}"
