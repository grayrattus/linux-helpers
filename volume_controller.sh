#!/bin/bash

output_file=$1
volume=$2
yad --scale --vertical --posx=-1 --posy=-1 \
	--no-buttons \
	--close-on-unfocus \
	--width=10 \
	--height=300 \
	--print-partial --value=$volume --min-value=0 --max-value=100 \
	--title="Select volume" \
	--text="Volume" > $output_file
