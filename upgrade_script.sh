#!/usr/bin/env bash

set -uo pipefail

if [[ -t 1 ]]; then
    readonly CLEAR=$'\033[0m'
    readonly RED=$'\033[0;31m'
    readonly GREEN=$'\033[0;32m'
else
    readonly CLEAR=''
    readonly RED=''
    readonly GREEN=''
fi

SUDO=()
if (( EUID != 0 )); then
    SUDO=(sudo)
fi

run_step() {
    local label="$1"
    shift

    printf '\n==> %s\n' "$label"

    if "$@"; then
        printf '%s%s done%s\n' "$GREEN" "$label" "$CLEAR"
    else
        local rc=$?
        printf '%s%s failed. Error code: %d%s\n' "$RED" "$label" "$rc" "$CLEAR" >&2
        exit "$rc"
    fi
}

main() {
    if (( EUID != 0 )); then
        sudo -v
    fi

    run_step "Update" "${SUDO[@]}" apt-get update
    run_step "Dist-upgrade" "${SUDO[@]}" apt-get dist-upgrade -y
    run_step "Autoremove" "${SUDO[@]}" apt-get autoremove -y
}

main "$@"
