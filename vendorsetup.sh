#!/usr/bin/env bash

# ---------- Colors ----------
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
NC="\033[0m"

fatal() { echo -e "${RED}[FATAL] $1${NC}"; exit 1; }
info()  { echo -e "${CYAN}$1${NC}"; }
success(){ echo -e "${GREEN}$1${NC}"; }
warn()  { echo -e "${YELLOW}$1${NC}"; }

# ---------- Ensure Android env ----------
if ! command -v gettop &>/dev/null; then
    fatal "Android build env not loaded. Run: source build/envsetup.sh"
fi

croot() { cd "$(gettop)"; }


# ---------- CAF audio updates ----------
update_repo() {
    local path="$1"
    local url="$2"
    local branch="$3"

    [[ -d "$path/.git" ]] || fatal "Missing repo: $path"
    cd "$path"
    git fetch "$url" "$branch"
    git reset --hard FETCH_HEAD
    croot
}

update_repo hardware/qcom-caf/sm8650/audio/agm \
https://github.com/sm8635-dev/vendor_qcom_opensource_agm \
lineage-23.2-caf-sm8650

update_repo hardware/qcom-caf/sm8650/audio/graphservices \
https://github.com/LineageOS/android_vendor_qcom_opensource_audioreach-graphservices \
lineage-23.2-caf-sm8650

update_repo hardware/qcom-caf/sm8650/audio/pal \
https://github.com/LineageOS/android_vendor_qcom_opensource_arpal-lx \
lineage-23.2-caf-sm8650

update_repo hardware/qcom-caf/sm8650/audio/primary-hal \
https://github.com/LineageOS/android_hardware_qcom_audio-ar \
lineage-23.2-caf-sm8650

cd hardware/lineage/interfaces
git fetch https://github.com/sm8635-dev/hardware_lineage_interfaces sixteen
git reset --hard FETCH_HEAD
croot

cd device/lineage/sepolicy
git fetch https://github.com/sm8635-dev/device_lineage_sepolicy sixteen
git reset --hard FETCH_HEAD
croot

rm -rf vendor/yaap/signing/keys
git clone -b master https://github.com/Powerhouse-Lab/keys vendor/yaap/signing/keys

success "All resources synced successfully ✅"
