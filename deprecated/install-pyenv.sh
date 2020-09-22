#!/usr/bin/env bash
set -euo pipefail

# Temporarily disabled due to difficulty in getting system python3-dnf to
# work with it
PYTHON_VERSION=${PYTHON_VERSION:-3.8.5}

if command -v pyenv > /dev/null; then
    echo "pyenv already installed, nothing to do..."
    exit 0
fi

# Set up prerequisites
echo "Checking and installing prerequisites for pyenv..."
sudo dnf upgrade
sudo dnf install -y curl ca-certificates git

# Installs to PYENV_ROOT="${HOME}/.pyenv" by default
curl https://pyenv.run | bash

# Set to bashrc for persistent PATH effect
cat <<"EOT" >> "${HOME}/.bashrc"

export PATH="${HOME}/.pyenv/bin:${PATH}"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOT

# Need to temporarily disable u flag
set +u

# And also allow this session to have the effect
# (source doesn't work in subshell)
export PATH="${HOME}/.pyenv/bin:${PATH}"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

pyenv --version
set -u

# Set the global version
echo "Checking and installing prerequisites for python build..."
sudo dnf install -y \
    "@Development Tools" \
    wget \
    llvm \
    openssl-devel \
    tk-devel \
    libffi-devel \
    readline-devel \
    ncurses-devel \
    sqlite-devel \
    xz-devel \
    zlib-devel \
    bzip2-devel

# Get rid of the installed python2 symbolic link due to python-openssl to prevent confusion
# echo "Get rid of python2 from PATH before install python via pyenv..."
# sudo rm -f /usr/bin/python2

pyenv install "${PYTHON_VERSION}"
pyenv global "${PYTHON_VERSION}"

# Test the install python works
python --version
