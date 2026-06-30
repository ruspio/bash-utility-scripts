#!/usr/bin/env bash

set -euo pipefail

readonly SCHEMA="org.gnome.desktop.peripherals.touchpad"
readonly KEY="send-events"

show_usage() {
    printf 'Usage:\n'
    printf '  %s                            Show current touchpad status\n' "$0"
    printf '  %s -s | --status               Show current touchpad status\n' "$0"
    printf '  %s -e | --enable               Enable touchpad\n' "$0"
    printf '  %s -d | --disable              Disable touchpad\n' "$0"
    printf '  %s -m | --disabled-on-mouse    Disable touchpad when external mouse is connected\n' "$0"
}

require_gsettings() {
    if ! command -v gsettings > /dev/null 2>&1; then
        printf 'Error: gsettings command not found.\n' >&2
        exit 127
    fi
}

show_status() {
    local status

    if status=$(gsettings get "$SCHEMA" "$KEY"); then
        printf 'Touchpad status: %s\n' "$status"
    else
        local rc=$?
        printf 'Error: failed to read touchpad status. Exit code: %d\n' "$rc" >&2
        exit "$rc"
    fi
}

set_touchpad() {
    local setting="$1"

    if gsettings set "$SCHEMA" "$KEY" "$setting"; then
        printf 'Touchpad setting changed to: %s\n' "$setting"
    else
        local rc=$?
        printf 'Error: failed to set touchpad setting to: %s. Exit code: %d\n' "$setting" "$rc" >&2
        exit "$rc"
    fi
}

main() {
    require_gsettings

    if (( $# == 0 )); then
        show_status
        exit 0
    fi

    if (( $# > 1 )); then
        printf 'Error: only one argument is allowed.\n\n' >&2
        show_usage >&2
        exit 1
    fi

    local setting=""

    case "$1" in
        -s|--status)
            show_status
            exit 0
            ;;

        -e|--enable)
            setting="enabled"
            ;;

        -d|--disable)
            setting="disabled"
            ;;

        -m|--disabled-on-mouse)
            setting="disabled-on-external-mouse"
            ;;

        --help|-h)
            show_usage
            exit 0
            ;;

        *)
            printf 'Error: unknown option: %s\n\n' "$1" >&2
            show_usage >&2
            exit 1
            ;;
    esac

    set_touchpad "$setting"
    show_status
}

main "$@"