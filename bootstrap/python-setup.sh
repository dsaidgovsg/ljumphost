#!/usr/bin/env bash
set -euo pipefail

if command -v pyenv > /dev/null; then
    echo "pyenv already installed, nothing to do..."
    exit 0
fi

# Global variables, can override if preferred
PYTHON_VERSION=${PYTHON_VERSION:-3.8.5}

# Set up prerequisites
apt-get update
apt-get install -y --no-install-recommends curl ca-certificates git

export PYENV_ROOT=/opt/pyenv
curl https://pyenv.run | bash

echo "export PYENV_ROOT=${PYENV_ROOT}" >> "${HOME}/.bashrc"

cat <<"EOT" >> "${HOME}/.bashrc"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOT

# Need to temporarily disable u flag
set +u

# shellcheck source=/dev/null
source "${HOME}/.bashrc"
set -u

# Set the global version
apt-get install -y --no-install-recommends \
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
