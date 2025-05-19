#!/bin/bash

set -e

if ! pgrep opensnitch-ui &>/dev/null; then
    if which opensnitch-ui &>/dev/null; then
        swaymsg "exec /usr/local/bin/opensnitch-ui"
    fi
fi

if ! pgrep rythmbox &>/dev/null; then
    if which rythmbox &>/dev/null; then
        swaymsg "exec /usr/bin/rythmbox"
    fi
fi

