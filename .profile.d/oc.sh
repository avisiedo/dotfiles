
if command -v oc &>/dev/null; then
	source <(oc completion $(basename $SHELL))
fi
