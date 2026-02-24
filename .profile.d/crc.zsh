if which -s crc &>/dev/null; then
  source <(crc oc-env)
  source <(crc completion $(basename "$SHELL"))
fi

if which -s oc &>/dev/null; then
  source <(oc completion $(basename "$SHELL"))
fi
