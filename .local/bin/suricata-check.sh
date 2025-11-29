#!/bin/bash

if which suricata &>/dev/null; then
	run0 suricata -T -c /etc/suricata/suricata.yaml -v
else
	echo "error: suricata is not installed"
	exit 1
fi

