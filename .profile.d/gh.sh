##
# Add completion for github cli tool
##
if tty -s &>/dev/null && which gh &>/dev/null; then
  source <(gh completion -s "$(basename "$SHELL")")
  # Only load if permissions are 0400
  [ ! -e ~/.github.conf ] || {
    if stat ~/.github.conf | grep Access | grep -q 0400; then
      source ~/.github.conf
    else
      printf "error: ~/.github.conf wrong permissions: no 0400\n" >&2
    fi
  }
fi
