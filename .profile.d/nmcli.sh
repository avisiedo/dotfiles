if tty -s && [ -e ~/.local/bin/setup-bridge128 ] && [ ! -e /var/run/.containerenv ]; then
  if ! nmcli device show bridge128 | grep IP4.ADDRESS | grep -q -v -- --; then
    echo "Setting up bridge128" >&2
    ~/.local/bin/setup-bridge128
  fi
fi
