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

# Vendor
info "Cloning vendor tree"
git clone -b custom --depth 1 https://github.com/Poco-F6-resources/android_vendor_xiaomi_peridot.git vendor/xiaomi/peridot || fatal "Vendor tree clone failed!"

# Kernel sources
info "Cloning Kernel sources"
git clone -b 16.2 --depth 1 https://github.com/Poco-F6-resources/android_kernel_xiaomi_sm8635.git kernel/xiaomi/sm8635 || fatal "Kernel source clone failed!"

warn "Cleaning kernel modules directory (if exists)"
rm -rf kernel/xiaomi/sm8635-modules
info "Cloning kernel modules"
git clone -b 16.2 https://github.com/Poco-F6-resources/android_kernel_xiaomi_sm8635-modules.git kernel/xiaomi/sm8635-modules || fatal "Kernel modules clone failed!"

warn "Cleaning kernel devicetrees directory (if exists)"
rm -rf kernel/xiaomi/sm8635-devicetrees
info "Cloning kernel devicetrees"
git clone -b 16.2 https://github.com/Poco-F6-resources/android_kernel_xiaomi_sm8635-devicetrees.git kernel/xiaomi/sm8635-devicetrees || fatal "Kernel devicetrees clone failed!"

# Hardware xiaomi
info "Cloning hardware xiaomi"
warn "Cleaning hardware/xiaomi directory (if exists)"
rm -rf hardware/xiaomi
git clone -b 16.2 https://github.com/Poco-F6-resources/hardware_xiaomi.git hardware/xiaomi || fatal "Hardware xiaomi clone failed!"

# Dolby
info "Cloning Lunaris Dolby"
warn "Cleaning Old Dolby repo"
git clone -b 16 https://github.com/Poco-F6-resources/hardware_dolby.git hardware/dolby || fatal "Dolby clone failed"

# Mi Cam
info "Cloning Normal Mi Cam"
info "Cloning Miuicamera vendor"
git clone -b 16.2 --depth 1 https://github.com/Poco-F6-resources/proprietary_vendor_xiaomi_peridot-miuicamera.git vendor/xiaomi/peridot-miuicamera || fatal "Vendor miuicamera clone failed!"

info "Cloning Miuicamera device"
git clone -b lineage-23.2 --depth 1 https://github.com/Poco-F6-resources/android_device_xiaomi_peridot-miuicamera.git device/xiaomi/peridot-miuicamera || fatal "Device miuicamera clone failed!"

return 0
