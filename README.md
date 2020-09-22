# `ljumphost`

True jumphost set-up and instructions repository.

This is a two-step set-up, bootstrap + ansible. This assumes a RHEL8 distro with
`dnf` being the distro package manager, and is tested against a standard RHEL8
AMI.

You will need to `git clone` this into the true jumphost instance.

## Bootstrap

Simply run:

```bash
./bootstrap.sh
```

which installs the following:

- `python`
  - Uses the default system / `dnf` set-up which is version `3.6.Z`. Since many
    of the other dependencies such as `python3-dnf` is highly dependent on the
    system Python3 set-up, it is not advisable to attempt to run a custom
    version of Python3.
- `ansible`
  - Default version to install via `pip` is `2.7.18`. Run the bootstrap script
    with env var `ANSIBLE_VERSION=X.Y.Z` to override the version.
  - The slightly older version `2.7.Z` is intentionally chosen at this point
    since many of the Ansible playbooks heavily depend on this version to work.

Once the `./bootstrap.sh` has been run to completion, you are advised to either
exit and start a new shell, or run `exec $SHELL` to inherit any possibly new
PATH values for subsequent set-up parts.

## Ansible installs

You will need the previous bootstrap script to run successfully, and the current
shell must have the update `PATH` env vars from the previous section.

Simply run:

```bash
./run-ansible.sh
```

to have all the relevant Terraform and other Hashicorp CLI tools installed.

By default, the "convenience" features are automatically enabled. These include:

- Removal of `TMOUT` to prevent SSH shell session from timeout
- Allowing SSH service TCP forwarding
- Adding current user to `docker` group
  - This requires logout and login of shell to take effect.
  - For VSCode Remote SSH, you need to run the command "Kill VS Code Server on
    Host" first:
    <https://github.com/microsoft/vscode-remote-release/issues/1997>.

If you do not want the "convenience" features to be enabled, you should instead
run:

```bash
ALLOW_CONVENIENCE=false ./run-ansible.sh
```
