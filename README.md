# `ljumphost`

True jumphost set-up and instructions repository.

This is a two-step set-up, bootstrap + ansible. This assumes a RHEL8 distro with
`dnf` being the distro package manager, and is tested against a standard RHEL8
AMI.

You will need to `git clone` this into the true jumphost instance.

## Bootstrap

Simply run `./bootstrap.sh`. This installs the following:

- `pyenv`
  - For pinning down the exact Python version to install, which helps to
    eliminate any discrepancies when running `ansible` or other `pip install`
    commands.
  - Due to difficulty in installing into `root` and then sharing it
    to the user, the bootstrap script chooses to follow the default and install
    everything into the `$HOME` directory, which is a suitable choice under
    AWS context.
- `python`
  - Default version to install via `pyenv` is `3.8.5`. Run the bootstrap script
    with env var `PYTHON_VERSION=X.Y.Z` to override the version.
- `ansible`
  - Default version to install via `pip` is `2.7.18`. Run the bootstrap script
    with env var `ANSIBLE_VERSION=X.Y.Z` to override the version.
  - The slightly older version `2.7.Z` is intentionally chosen at this point
    since many of the Ansible playbooks heavily depend on this version to work.

Once the `./bootstrap.sh` has been run to completion, either exit and start a
new shell, or run `exec $SHELL` to inherit the new PATH values to locate the
above executables.

## Ansible installs

You will need the previous bootstrap script to run successfully, and the current
shell must have the update `PATH` env vars from the previous section.

Simply run `run-ansible.sh`, to have all the relevant Terraform and other
Hashicorp CLI tools instaled.

Once the `./run-ansible.sh` has been run to completion, either exit and start a
new shell, or run `exec $SHELL` for `pyenv` to perform the re-hashing to
generate the shims for the new CLIs installed via `pip`.
