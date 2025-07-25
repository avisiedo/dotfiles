if tty -s &>/dev/null && which ocm &>/dev/null; then
	source <(ocm completion bash)
fi
