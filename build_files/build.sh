#!/bin/bash

set ${SET_X:+-x} -eou pipefail
########################### UTILITY FUNCTIONS ##########################
trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG
log() {
  echo "=== $* ==="
}
############################### SETTINGS ###############################
log "Change default editor"
dnf5 swap -y nano-default-editor vim-default-editor

#### Example for enabling a System Unit File
log "Enable podman to startup after boot"
systemctl enable podman.socket
