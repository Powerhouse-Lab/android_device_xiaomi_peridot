#!/bin/bash

# Define colour codes
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
NC="\033[0m" # No Color

fatal() {
    echo -e "${RED}[FATAL] $1${NC}"
    return 1
}

info() {
    echo -e "${CYAN}$1${NC}"
}

success() {
    echo -e "${GREEN}$1${NC}"
}

warn() {
    echo -e "${YELLOW}$1${NC}"
}

info "Cloning All resources"

# Hardware xiaomi
info "Cloning hardware xiaomi"
warn "Cleaning hardware/xiaomi directory (if exists)"
rm -rf hardware/xiaomi
git clone -b 16.2 https://github.com/Poco-F6-resources/hardware_xiaomi.git hardware/xiaomi || fatal "Hardware xiaomi clone failed!"

# Patch
info "Applying AV patch for dolby"
cd frameworks/av
git remote add lab https://github.com/peridot-lab/yaap_frameworks_av.git && git fetch lab && git cherry-pick 699ff01 || fatal "frameworks/av patch  not failed!"
info "Patch applied successfully"
croot

success "All resources cloned successfully!"
return 0
