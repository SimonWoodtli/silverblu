#!/bin/bash

set -ouex pipefail

# The superior default editor
dnf5 swap -y nano-default-editor vim-default-editor

#### Example for enabling a System Unit File
systemctl enable podman.socket
